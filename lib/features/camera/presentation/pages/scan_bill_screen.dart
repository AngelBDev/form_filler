import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/core/helpers/_helpers.dart';
import 'package:form_filler/core/presentation/atoms/defult_snack_bar.dart';
import 'package:form_filler/features/camera/presentation/templates/scan_bill_template.dart';
import 'package:form_filler/features/form_fill/data/models/bill_response.dart';
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

  BillResponse _billResponse;
  File _image;

  void _saveBill() {
    Navigator.of(context).pop(_billResponse);
  }

  void _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() => _image = File(pickedFile.path));
  }

  void _scanBill(File image) async {
    final response = await BlocProvider.of<BillCubit>(context).scanBill(image);

    setState(() {
      _billResponse = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScanBillTemplate(
      image: _image,
      scanBill: _scanBill,
      getImage: _getImage,
      saveBill: _saveBill,
      stateListener: _stateListener,
    );
  }

  void _stateListener(context, state) {
    BillInitial _state = state;

    if (_state.errors == BillErrors.server_error) {
      showSnackBar(
        context,
        defaultSnackBar(
          message:
              'Ha ocurrido un error inesperado en nuestros servidores, por favor intentalo mas tarde',
          type: SnackBarType.error,
        ),
      );
    }

    if (_state.errors == BillErrors.null_image) {
      showSnackBar(
        context,
        defaultSnackBar(
          message: 'No has seleccionado ninguna imagen para escanear.',
          type: SnackBarType.warning,
        ),
      );
    }

    // TODO: implement NOT ENOUGH INFO MESSAGE

    /*  if (_state.errors == BillErrors.not_enough_info) {
      showSnackBar(
        context,
        defaultSnackBar(
          message: 'No has seleccionado ninguna imagen para escanear.',
          type: SnackBarType.warning,
        ),
      );
    } */
  }
}
