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

  final List<Bill> _bills = [];

  List<File> _images;

  @override
  void dispose() {
    _clientRNCController.dispose();
    super.dispose();
  }

  void _editBill(Bill bill, int index) async {
    final updatedBill = await _getBill(bill);

    if (updatedBill == null) return;

    setState(() {
      _bills[index] = updatedBill;
    });
  }

  void _addNewBill() async {
    final newBill = await _getBill();

    if (newBill == null) return;

    setState(() {
      _bills.add(newBill);
    });
  }

  Future<Bill> _getBill([Bill billToEdit]) async {
    final bill = await Navigator.of(context).pushNamed(
      BillFormScreen.route,
      arguments: BillFormScreenParams(bill: billToEdit),
    );

    return bill;
  }

  void _removeBill(Bill value, int index) {
    setState(() {
      _bills.removeAt(index);
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
      onTapAddBill: _addNewBill,
      onTapBillField: _editBill,
      onTapBillRemove: _removeBill,
      onSubmit: _onSubmit,
    );
  }

  void _onChangePeriodDate(date) {
    setState(() {
      _periodDate = date;
    });
  }
}
