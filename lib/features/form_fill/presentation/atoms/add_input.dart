import 'package:flutter/material.dart';

class AddInput extends StatelessWidget {
  const AddInput({
    Key key,
    this.hint,
    this.width,
    @required this.onTap,
  }) : super(key: key);
  final Widget hint;
  final double width;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 15),
          width: width,
          child: hint,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Theme.of(context).accentColor,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        Positioned(
          right: -8,
          bottom: -1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
