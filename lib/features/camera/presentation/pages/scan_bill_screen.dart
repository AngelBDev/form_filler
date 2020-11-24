import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/features/camera/presentation/templates/scan_bill_template.dart';
import 'package:form_filler/features/form_fill/state/bill_state/bill_cubit.dart';
import 'package:image_picker/image_picker.dart';

class ScanBillScreen extends StatefulWidget {
  ScanBillScreen({Key key}) : super(key: key);
  static const String route = 'scan-bill';

  @override
  _ScanBillScreenState createState() => _ScanBillScreenState();
}

class _ScanBillScreenState extends State<ScanBillScreen> {
  final _picker = ImagePicker();
  File _image;

  void _saveBill() {
    Navigator.of(context).pop();
  }

  void _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() => _image = File(pickedFile.path));
  }

  void _scanBill(File image) async {
    BlocProvider.of<BillCubit>(context).scanBill(image);
  }

  @override
  Widget build(BuildContext context) {
    return ScanBillTemplate(
      scanBill: _scanBill,
      getImage: _getImage,
      saveBill: _saveBill,
    );
  }
}
