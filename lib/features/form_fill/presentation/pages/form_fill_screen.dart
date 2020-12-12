import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/core/helpers/_helpers.dart';
import 'package:form_filler/core/presentation/atoms/defult_snack_bar.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/domain/entities/form_606.dart';
import 'package:form_filler/features/form_fill/presentation/pages/bill_form_screen.dart';
import 'package:form_filler/features/form_fill/presentation/templates/form_fill_template.dart';
import 'package:form_filler/features/form_fill/state/form_606_state/form_606_cubit.dart';

class FormFillScreen extends StatefulWidget {
  static const route = 'form';
  const FormFillScreen({Key key}) : super(key: key);

  @override
  _FormFillScreenState createState() => _FormFillScreenState();
}

class _FormFillScreenState extends State<FormFillScreen> {
  final TextEditingController _clientRNCController = TextEditingController();
  DateTime _periodDate = DateTime.now();

  final List<Bill> _bills = [];

  @override
  void dispose() {
    _clientRNCController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormFillTemplate(
      bills: _bills,
      clientRNCController: _clientRNCController,
      periodDate: _periodDate,
      onChangePeriodDate: _onChangePeriodDate,
      onChangeRncField: _onChangeRncField,
      onTapAddBill: _addNewBill,
      onTapBillField: _editBill,
      onTapBillRemove: _removeBill,
      onSubmit: _onSubmit,
      form606Listener: form606Listener,
    );
  }

  void _onChangePeriodDate(date) {
    setState(() {
      _periodDate = date;
    });
  }

  void _onChangeRncField(String value) {
    final startedFilling = value.length == 1;

    value = value.trim();

    if (value.isEmpty || startedFilling) {
      setState(() {});
    }
  }

  void _addNewBill() async {
    final newBill = await _getBill();

    if (newBill == null) return;

    setState(() {
      _bills.add(newBill);
    });
  }

  void _editBill(Bill bill, int index) async {
    final updatedBill = await _getBill(bill);

    if (updatedBill == null) return;

    setState(() {
      _bills[index] = updatedBill;
    });
  }

  Future<Bill> _getBill([Bill billToEdit]) async {
    final bill = await Navigator.of(context).pushNamed(
      BillFormScreen.route,
      arguments: BillFormScreenParams(
        bill: billToEdit,
      ),
    );

    return bill;
  }

  void _removeBill(Bill value, int index) {
    setState(() {
      _bills.removeAt(index);
    });
  }

  void _onSubmit(BuildContext context) async {
    final formData = _getFormData();
    final canSubmitForm = _validateForm();

    if (formData == null) return;

    if (canSubmitForm) {
      BlocProvider.of<Form606Cubit>(context).submitForm(form: formData);
    }
  }

  bool _validateForm() {
    var canSubmitForm = false;

    if (_bills.isEmpty) return canSubmitForm;
    if (_periodDate == null) return canSubmitForm;
    if (_clientRNCController.text.trim().isEmpty) return canSubmitForm;

    final isPeriodGreaterOrEqualThanBillDates =
        _checkIfPeriodGreaterOrEqualThanBillDates(_bills);

    if (isPeriodGreaterOrEqualThanBillDates) {
      canSubmitForm = true;
    } else {
      _warnPeriodError();
    }

    return canSubmitForm;
  }

  bool _checkIfPeriodGreaterOrEqualThanBillDates(List<Bill> bills) {
    var isPeriodGreaterOrEqualThanBillDates = bills.every(
      (bill) {
        final billMonthDate = _cleanDateDay(bill.date);
        final periodMonthDate = _cleanDateDay(_periodDate);
        final compareNumber = billMonthDate.compareTo(periodMonthDate);
        // zero is equal, plus number is after, minus number is before
        return compareNumber == 0;
      },
    );
    return isPeriodGreaterOrEqualThanBillDates;
  }

  DateTime _cleanDateDay(DateTime date) {
    final billMonthDate = date.subtract(
      Duration(
        days: date.day - 1,
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second,
        milliseconds: date.millisecond,
        microseconds: date.microsecond,
      ),
    );
    return billMonthDate;
  }

  void _warnPeriodError() {
    showSnackBar(
      context,
      defaultSnackBar(
        type: SnackBarType.warning,
        message: 'El periodo debe coincidir con las fechas de las facturas.',
      ),
    );
  }

  Form606 _getFormData() {
    final formData = Form606(
      period: _periodDate,
      clientRNC: _clientRNCController.text,
      bills: _bills,
    );

    return formData;
  }

  void form606Listener(BuildContext context, Form606State state) {
    if (state is Form606Initial) {
      if (state.errors == FormErrors.server_error) {
        showSnackBar(
          context,
          defaultSnackBar(
            message:
                'Ha ocurrido un error en nuestros servidores, por favor intenta de nuevo mas tarde.',
            type: SnackBarType.error,
          ),
        );
      }

      if (state.downloadState.progress == 100) {
        showSnackBar(
          context,
          defaultSnackBar(
            message: 'Se ha creado el archivo con exito',
            type: SnackBarType.success,
          ),
        );
        _resetState();
      }
    }
  }

  void _resetState() {
    setState(() {
      _clientRNCController.clear();
      _periodDate = DateTime.now();
      _bills.clear();
    });
  }
}
