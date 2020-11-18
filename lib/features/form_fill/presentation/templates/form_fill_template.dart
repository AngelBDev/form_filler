import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_filler/core/presentation/hoc/focus_handler.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/molecules/form_606_variant.dart';

class FormFillTemplate extends StatelessWidget {
  const FormFillTemplate({
    Key key,
    @required this.clientRNCController,
    @required this.periodDate,
    @required this.onTapAddBill,
    @required this.onTapBillField,
    @required this.onTapBillRemove,
    @required this.onSubmit,
    @required this.onChangePeriodDate,
    this.images,
    this.bills,
  }) : super(key: key);

  final List<Bill> bills;
  final List<File> images;
  final DateTime periodDate;
  final TextEditingController clientRNCController;
  final void Function() onTapAddBill;
  final void Function(Bill value, int index) onTapBillRemove;
  final void Function(Bill value) onTapBillField;
  final void Function(BuildContext context) onSubmit;
  final void Function(DateTime date) onChangePeriodDate;

  @override
  Widget build(BuildContext context) {
    return FocusHandler(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final canSubmit = bills.isNotEmpty &&
        periodDate.toString().trim().isNotEmpty &&
        clientRNCController.text.trim().isNotEmpty;

    return AppBar(
      elevation: 0,
      title: Text(
        'DGII 606 Formulario',
        style: TextStyle(
          color: Colors.brown,
        ),
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.check,
            ),
            color: Colors.green,
            disabledColor: Colors.grey,
            onPressed: /* canSubmit ? */ () => onSubmit(context) /* : null */,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form606Variant(
        bills: bills,
        clientRNCController: clientRNCController,
        periodDate: periodDate,
        images: images,
        onTapAddBill: onTapAddBill,
        onTapBillRemove: onTapBillRemove,
        onTapBillField: onTapBillField,
        onChangePeriodDate: onChangePeriodDate,
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTapAddBill,
      tooltip: 'Seleccionar imagen',
      child: Icon(Icons.add),
    );
  }
}
