import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key key,
    @required this.onChange,
    @required this.dateSelected,
    @required this.labelText,
    @required this.maxYear,
    @required this.minYear,
  }) : super(key: key);

  final String labelText;
  final DateTime dateSelected;
  final int minYear;
  final int maxYear;

  final void Function(DateTime date) onChange;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dateSelected ?? DateTime.now(),
      firstDate: DateTime(minYear),
      lastDate: DateTime(maxYear),
    );

    if (picked != null && picked != dateSelected) {
      onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _dateSelected =
        dateSelected == null ? 'Date' : DateFormat.yMMMd().format(dateSelected);
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          enabled: true,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              _dateSelected,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
    );
  }
}
