import 'dart:io';

import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({Key key, this.image}) : super(key: key);

  final File image;
  @override
  Widget build(BuildContext context) {
    return image == null
        ? Container(
            width: 360,
            height: 400,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Text(
                'No image selected.',
              ),
            ),
          )
        : Container(
            color: Colors.black,
            child: Image.file(
              image,
              width: 360,
              height: 400,
              alignment: Alignment.center,
            ),
          );
  }
}
