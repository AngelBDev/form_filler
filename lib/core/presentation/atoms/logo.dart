import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width60Percent = MediaQuery.of(context).size.width * .70;
    final size = width60Percent > 450 ? 450 : width60Percent;

    return Image(
      image: AssetImage(
        'assets/images/logo_200x200.png',
      ),
      width: size,
    );
  }
}
