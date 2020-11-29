import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/features/camera/presentation/atoms/image_display.dart';
import 'package:form_filler/features/form_fill/state/bill_state/bill_cubit.dart';
import 'package:image_picker/image_picker.dart';

class ScanBillTemplate extends StatelessWidget {
  const ScanBillTemplate({
    Key key,
    @required this.saveBill,
    @required this.scanBill,
    @required this.getImage,
    @required this.stateListener,
    this.image,
  }) : super(key: key);

  final File image;

  final void Function() saveBill;

  final void Function(File) scanBill;

  final void Function(ImageSource) getImage;

  final void Function(BuildContext, BillState) stateListener;

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
    return Builder(
      builder: (context) => BlocListener<BillCubit, BillState>(
        listener: stateListener,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageDisplay(image: image),
            ],
          ),
        ),
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
