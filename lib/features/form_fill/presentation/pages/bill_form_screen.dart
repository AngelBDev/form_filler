import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/data/models/bill_response.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/templates/bill_form_template.dart';

class BillFormScreen extends StatefulWidget {
  static const route = 'bill-form';
  BillFormScreen({Key key}) : super(key: key);

  @override
  _BillFormScreenState createState() => _BillFormScreenState();
}

class _BillFormScreenState extends State<BillFormScreen> {
  final TextEditingController _rncController = TextEditingController();
  final TextEditingController _ncfController = TextEditingController();
  final TextEditingController _grossTotalController = TextEditingController();
  final TextEditingController _itbisController = TextEditingController();

  Bill _bill;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initRouteParams();
    _initMembers();
  }

  void _initMembers() {
    _rncController.text = _bill.rnc;
    _ncfController.text = _bill.ncf;
    _itbisController.text = _bill.itbis?.toString();
    _grossTotalController.text = _bill.grossTotal?.toString();
  }

  void _initRouteParams() {
    final BillFormScreenParams arguments =
        ModalRoute.of(context).settings.arguments;

    _bill = arguments.bill ?? Bill();
  }

  @override
  void dispose() {
    _rncController?.dispose();
    _ncfController?.dispose();
    _grossTotalController?.dispose();
    _itbisController?.dispose();

    super.dispose();
  }

  void _onChangeTransactionType(int value) {
    setState(() {
      final updatedBill = _bill.copyWith(transactionType: value);
      _bill = updatedBill;
    });
  }

  void _onTapTransactionType() {}

  void _onChangePaymentType(int value) {
    setState(() {
      final updatedBill = _bill.copyWith(paymentType: value);
      _bill = updatedBill;
    });
  }

  void _onTapPaymentType() {}

  void _onChangeDate(DateTime value) {
    setState(() {
      final updatedBill = _bill.copyWith(date: value);
      _bill = updatedBill;
    });
  }

  void _onSubmit(Bill bill) {
    final updateddBill = _addBillSubmitData(bill);
    Navigator.of(context).pop(updateddBill);
  }

  Bill _addBillSubmitData(Bill bill) {
    final itbis = int.tryParse(_itbisController.text);
    final grossTotal = int.tryParse(_grossTotalController.text);
    final updatedBill = bill.copyWith(
      rnc: _rncController.text,
      ncf: _ncfController.text,
      itbis: itbis,
      grossTotal: grossTotal,
    );

    return updatedBill;
  }

  void _onPressedRncOption(String value) {
    setState(() {
      _rncController.text = value;
      _bill = _bill.copyWith(rnc: value);
    });
  }

  void _onPressedNcfOption(String value) {
    setState(() {
      _ncfController.text = value;
      _bill = _bill.copyWith(ncf: value);
    });
  }

  void _onPressedGrossTotalOption(num value) {
    _grossTotalController.text = '$value';
    setState(() {
      _bill = _bill.copyWith(grossTotal: value);
    });
  }

  void _onPressedItbisOption(num value) {
    _itbisController.text = '$value';
    setState(() {
      _bill = _bill.copyWith(itbis: value);
    });
  }

  void _onPressedDateOption(DateTime value) {
    setState(() {
      _bill = _bill.copyWith(date: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    /*    return BlocBuilder<BillCubit, BillState>(
      builder: (context, state) {
        BillInitial _state = state; */

    return BillFormTemplate(
      bill: _bill,
      /*     billResponse: _state.bill, */
      billResponse: BillResponse(),
      rncController: _rncController,
      ncfController: _ncfController,
      grossTotalController: _grossTotalController,
      itbisController: _itbisController,
      onPressedRncOption: _onPressedRncOption,
      onPressedNcfOption: _onPressedNcfOption,
      onPressedGrossTotalOption: _onPressedGrossTotalOption,
      onPressedItbisOption: _onPressedItbisOption,
      onPressedDateOption: _onPressedDateOption,
      onChangePaymentType: _onChangePaymentType,
      onTapPaymentType: _onTapPaymentType,
      onChangeTransactionType: _onChangeTransactionType,
      onTapTransactionType: _onTapTransactionType,
      onChangeDate: _onChangeDate,
      onSubmit: _onSubmit,
    );
    /*  },
    ); */
  }
}

class BillFormScreenParams extends Equatable {
  final Bill bill;

  BillFormScreenParams({
    this.bill,
  });

  @override
  List<Object> get props => [bill];
}
