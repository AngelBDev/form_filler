import 'package:flutter/material.dart';
import 'package:form_filler/core/presentation/atoms/neumorphic_container.dart';

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
    return NeumorphicContainer(
      primaryColor: Theme.of(context).accentColor,
      child: Container(
        padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Type>(
            items: items,
            value: value,
            onChanged: onChanged,
            dropdownColor: Theme.of(context).accentColor.withOpacity(.9),
            isExpanded: true,
            hint: DefaultTextStyle(
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              child: hint,
            ),
          ),
        ),
      ),
    );
  }
}
