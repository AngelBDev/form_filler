import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_filler/features/camera/presentation/atoms/image_display.dart';
import 'package:image_picker/image_picker.dart';

class ScanBillTemplate extends StatelessWidget {
  const ScanBillTemplate({
    Key key,
    @required this.saveBill,
    @required this.scanBill,
    @required this.getImage,
    this.image,
  }) : super(key: key);

  final File image;

  // TODO: IMPLEMENT SAVE BILL
  final void Function() saveBill;

  // TODO: IMPLEMENT SCAN BILL
  final void Function(File) scanBill;

  // TODO: IMPLEMENT GET IMAGE FROM GALLERY AND CAMERA
  final void Function(ImageSource) getImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.check,
          ),
          onPressed: saveBill,
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImageDisplay(),
        ],
      ),
    );
  }

// TODO: IMPLEMENT IMAGE CONTROLS
//! TODO: DELETE COMMENT
/*   List<Widget> _buildImagePickerDisplayControls(BuildContext context) {
    return [
      AccentButton(
        onPressed: () {
          scanBill(image);
        },
        child: Row(
          children: [
            Icon(Icons.scanner_rounded),
            SizedBox(width: 15),
            Text('Escanear'),
          ],
        ),
      ),
      AccentButton(
        onPressed: () => getImage(
          ImageSource.gallery,
        ),
        child: Row(
          children: [
            Icon(Icons.photo_library),
            SizedBox(width: 15),
            Text('Galeria'),
          ],
        ),
      ),
    ];
  } */
}
