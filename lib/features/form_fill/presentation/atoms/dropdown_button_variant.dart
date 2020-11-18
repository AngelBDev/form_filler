import 'package:flutter/material.dart';

class DropdownButtonVariant<Type> extends StatelessWidget {
  const DropdownButtonVariant({
    Key key,
    @required this.items,
    @required this.onChanged,
    @required this.value,
    this.hint,
  }) : super(key: key);

  final List<DropdownMenuItem<Type>> items;
  final Type value;
  final void Function(Type item) onChanged;
  final Widget hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 1,
          color: Colors.brown,
          style: BorderStyle.solid,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Type>(
          items: items,
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          hint: DefaultTextStyle(
            style: TextStyle(
              color: Colors.brown,
              fontSize: 16,
            ),
            child: hint,
          ),
        ),
      ),
    );
  }
}
