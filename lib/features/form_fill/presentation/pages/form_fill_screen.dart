import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/pages/bill_form_screen.dart';
import 'package:form_filler/features/form_fill/presentation/templates/form_fill_template.dart';

class FormFillScreen extends StatefulWidget {
  static const route = 'form';
  const FormFillScreen({Key key}) : super(key: key);

  @override
  _FormFillScreenState createState() => _FormFillScreenState();
}

class _FormFillScreenState extends State<FormFillScreen> {
  final TextEditingController _clientRNCController = TextEditingController();
  DateTime _periodDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _clientRNCController.addListener(() {
      setState(() {});
    });
  }

  final List<Bill> _bills = [];

  List<File> _images;

  @override
  void dispose() {
    _clientRNCController.dispose();
    super.dispose();
  }

  void _onTapAddBill() {
    _onTapBillField();
  }

  void _onTapBillField([Bill value]) async {
    final bill = await Navigator.of(context).pushNamed(
      BillFormScreen.route,
      arguments: BillFormScreenParams(bill: value),
    );
    _addBill(bill);
  }

  void _addBill(Bill value) {
    if (value != null) {
      setState(() {
        _bills.add(value);
      });
    }
  }

  void _onTapBillRemove(Bill value, int index) {
    setState(() {
      _bills.remove(value);
    });
  }

  void _onSubmit(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return FormFillTemplate(
      bills: _bills,
      images: _images,
      clientRNCController: _clientRNCController,
      periodDate: _periodDate,
      onChangePeriodDate: _onChangePeriodDate,
      onTapAddBill: _onTapAddBill,
      onTapBillField: _onTapBillField,
      onTapBillRemove: _onTapBillRemove,
      onSubmit: _onSubmit,
    );
  }

  void _onChangePeriodDate(date) {
    setState(() {
      _periodDate = date;
    });
  }
}
