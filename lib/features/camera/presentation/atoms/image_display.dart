import 'dart:io';

import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({Key key, this.image}) : super(key: key);

  final File image;

  final width = 360.0;
  final height = 400.0;

  @override
  Widget build(BuildContext context) {
    return _buildDisplayImage(context);
  }

  Widget _buildDisplayImage(BuildContext context) {
    return image == null
        ? _buildEmptyImage(context)
        : _buildNotEmptyImage(context);
  }

  Widget _buildEmptyImage(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).accentColor,
      child: Center(
        child: Text(
          'No image selected.',
        ),
      ),
    );
  }

  Widget _buildNotEmptyImage(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Image.file(
        image,
        width: width,
        height: height,
        alignment: Alignment.center,
      ),
    );
  }
}
