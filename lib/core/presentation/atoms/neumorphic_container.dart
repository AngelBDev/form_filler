import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer({
    Key key,
    this.child,
    this.bevel = 2.0,
    this.primaryColor,
    this.secundaryColor,
    this.isDefaultContainer = false,
  }) : super(key: key);

  final Widget child;
  final double bevel;
  final Color primaryColor;
  final Color secundaryColor;
  final bool isDefaultContainer;
  @override
  Widget build(BuildContext context) {
    final _primaryColor = primaryColor ?? Theme.of(context).primaryColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: _primaryColor,
        gradient: !isDefaultContainer
            ? LinearGradient(
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffe4af7f),
                  Color(0xffffd097),
                ],
              )
            : null,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: child,
    );
  }
}
