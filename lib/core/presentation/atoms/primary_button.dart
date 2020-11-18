import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);
  final void Function() onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.brown,
      disabledColor: Theme.of(context).primaryColor.withOpacity(.5),
      onPressed: onPressed,
      child: child,
    );
  }
}
