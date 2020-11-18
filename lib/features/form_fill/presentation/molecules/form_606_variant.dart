import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/atoms/added_field.dart';
import 'package:form_filler/features/form_fill/presentation/atoms/date_picker.dart';
import 'package:form_filler/features/form_fill/presentation/atoms/text_field_variant.dart';

class Form606Variant extends StatelessWidget {
  const Form606Variant({
    Key key,
    @required this.images,
    @required this.bills,
    @required this.clientRNCController,
    @required this.periodDate,
    @required this.onTapBillField,
    @required this.onTapBillRemove,
    @required this.onChangePeriodDate,
    this.onTapAddBill,
  }) : super(key: key);

  final List<File> images;
  final List<Bill> bills;

  final DateTime periodDate;
  final TextEditingController clientRNCController;

  final void Function() onTapAddBill;
  final void Function(Bill value) onTapBillField;
  final void Function(Bill value, int index) onTapBillRemove;
  final void Function(DateTime) onChangePeriodDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: DatePicker(
            onChange: onChangePeriodDate,
            dateSelected: periodDate,
            labelText: 'Fecha',
            maxYear: 2025,
            minYear: 1950,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: TextFieldVariant(
            controller: clientRNCController,
            hintText: 'Cliente RNC',
          ),
        ),
        if (bills != null) ..._buildBillFields(context),
      ],
    );
  }

  List<Widget> _buildBillFields(BuildContext context) {
    return bills
        .map(
          (bill) => AddedField(
            width: double.infinity,
            onTapField: () => onTapBillField(bill),
            onTapRemove: () => onTapBillRemove(bill, 0),
            hint: Text(
              'Bill 1: ${bill.rnc}',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
        .toList();
  }
}
