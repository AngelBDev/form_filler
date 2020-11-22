import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/presentation/atoms/image_display.dart';

class ImagePickerDisplay extends StatelessWidget {
  const ImagePickerDisplay({
    Key key,
    this.image,
    @required this.controls,
    @required this.onGalleryPressed,
  }) : super(key: key);

  final File image;
  final void Function() onGalleryPressed;
  final List<Widget> controls;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: ImageDisplay(
            image: image,
          ),
        ),
        if (controls?.isNotEmpty ?? false)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...controls,
            ],
          ),
      ],
    );
  }
}
