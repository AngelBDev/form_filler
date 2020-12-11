import 'package:flutter/material.dart';
import 'package:form_filler/core/presentation/atoms/neumorphic_container.dart';
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
      lastDate: DateTime.now(),
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
      onTap: () => _selectDate(context),
      child: NeumorphicContainer(
        primaryColor: Theme.of(context).accentColor,
        isDefaultContainer: true,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                _dateSelected,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white.withOpacity(.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
