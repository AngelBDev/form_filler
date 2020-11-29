import 'dart:ui';

import 'package:flutter/material.dart';

class NeumorphismContainer extends StatelessWidget {
  NeumorphismContainer({
    Key key,
    this.child,
    this.bevel = 4.0,
    this.color,
  })  : blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).backgroundColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bevel * 5),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _color.mix(Colors.black, .1),
              _color,
              _color,
              _color.mix(_color.withRed(200), .5),
            ],
            stops: [
              0.0,
              .3,
              .6,
              1.0,
            ]),
        boxShadow: [
          BoxShadow(
            blurRadius: bevel,
            offset: -blurOffset,
            color: _color.mix(Color.fromRGBO(200, 200, 200, .5), .4),
          ),
          BoxShadow(
            blurRadius: bevel,
            offset: blurOffset,
            color: _color.mix(Color.fromRGBO(55, 55, 55, .5), .4),
          )
        ],
      ),
      child: child,
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
