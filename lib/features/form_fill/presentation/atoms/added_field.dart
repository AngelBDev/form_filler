import 'package:flutter/material.dart';

class AddedField extends StatelessWidget {
  const AddedField({
    Key key,
    this.hint,
    this.width,
    this.onTapField,
    this.onTapRemove,
  }) : super(key: key);

  final Widget hint;
  final double width;

  final Function() onTapField;
  final Function() onTapRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        GestureDetector(
          onTap: onTapField,
          child: Container(
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 15),
            child: hint,
            width: width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Theme.of(context).accentColor,
                  style: BorderStyle.solid,
                ),
              ),
              /*  borderRadius: BorderRadius.only(
                  
                  bottomRight: Radius.circular(5),
                ), */
            ),
          ),
        ),
        Positioned(
          right: -8,
          bottom: -1,
          child: GestureDetector(
            onTap: onTapRemove,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Icon(
                Icons.remove,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
