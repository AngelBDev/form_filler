import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/core/presentation/atoms/accent_button.dart';
import 'package:form_filler/core/presentation/hoc/focus_handler.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/molecules/bill_form.dart';
import 'package:form_filler/features/form_fill/presentation/molecules/image_picker_display.dart';
import 'package:form_filler/features/form_fill/state/cubit/bill_cubit.dart';
import 'package:image_picker/image_picker.dart';

class BillFormTemplate extends StatefulWidget {
  const BillFormTemplate({
    Key key,
    this.image,
    @required this.bill,
    @required this.rncController,
    @required this.ncfController,
    @required this.grossTotalController,
    @required this.itbisController,
    @required this.onChangePaymentType,
    @required this.onTapTransactionType,
    @required this.onTapPaymentType,
    @required this.onChangeTransactionType,
    @required this.onChangeDate,
    @required this.onSubmit,
    @required this.scanImage,
  }) : super(key: key);

  final File image;
  final Bill bill;
  final TextEditingController rncController;
  final TextEditingController ncfController;
  final TextEditingController grossTotalController;
  final TextEditingController itbisController;
  final void Function(int value) onChangePaymentType;
  final void Function() onTapPaymentType;
  final void Function(int value) onChangeTransactionType;
  final void Function() onTapTransactionType;
  final void Function(DateTime date) onChangeDate;
  final void Function() onSubmit;
  final void Function(File image) scanImage;

  @override
  _BillFormTemplateState createState() => _BillFormTemplateState();
}

class _BillFormTemplateState extends State<BillFormTemplate> {
  final _picker = ImagePicker();

  File _image;

  void _getImage(ImageSource imageSource) async {
    final _pickedFile = await _picker.getImage(source: imageSource);

    setState(() {
      if (_pickedFile != null) {
        _image = File(_pickedFile.path);
      } else {
        print('Seleccionar imagen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusHandler(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final isFormFilled = _validateForm();

    return AppBar(
      title: Text('Formulario de factura'),
      elevation: 0,
      actions: [
        if (isFormFilled)
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.green,
            ),
            onPressed: widget.onSubmit,
          ),
      ],
    );
  }

  bool _validateForm() {
    final isFormFilled = widget.rncController.text.trim().isNotEmpty &&
        widget.ncfController.text.trim().isNotEmpty &&
        widget.grossTotalController.text.trim().isNotEmpty &&
        widget.itbisController.text.trim().isNotEmpty &&
        (widget.bill?.transactionType ?? 0) > 0 &&
        (widget.bill?.paymentType ?? 0) > 0 &&
        (widget.bill?.date?.toString()?.isNotEmpty ?? false);
    return isFormFilled;
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Builder(
      builder: (context) => BlocListener<BillCubit, BillState>(
        listener: _listener,
        child: SingleChildScrollView(
          child: (Padding(
            padding: EdgeInsets.only(
              top: paddingTop,
            ),
            child: Column(
              children: [
                ImagePickerDisplay(
                  image: _image,
                  controls: _buildImagePickerDisplayControls(context),
                  onGalleryPressed: () => _getImage(
                    ImageSource.gallery,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: BillForm(
                    bill: widget.bill,
                    rncController: widget.rncController,
                    ncfController: widget.ncfController,
                    grossTotalController: widget.grossTotalController,
                    itbisController: widget.itbisController,
                    date: widget.bill?.date,
                    transactionType: widget.bill?.transactionType,
                    paymentType: widget.bill?.paymentType,
                    onChangePaymentType: widget.onChangePaymentType,
                    onTapPaymentType: widget.onTapPaymentType,
                    onChangeTransactionType: widget.onChangeTransactionType,
                    onTapTransactionType: widget.onTapTransactionType,
                    onChangeDate: widget.onChangeDate,
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  void _listener(BuildContext context, BillState state) {
    BillInitial _state = state;

    _listenToEmptyImageError(context, _state);
  }

  void _listenToEmptyImageError(
    context,
    BillInitial state,
  ) {
    if (state.errors == BillErrors.null_image) {
      _showSnackBar(context, 'No has seleccionado ninguna image', true);
    }
  }

  void _showSnackBar(context, String message, [bool isError = false]) {
    final color = isError ? Theme.of(context).errorColor : Colors.green;
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  List<Widget> _buildImagePickerDisplayControls(BuildContext context) {
    return [
      AccentButton(
        onPressed: () {
          widget.scanImage(_image);
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
        onPressed: () => _getImage(
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
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _getImage(ImageSource.camera),
      tooltip: 'Seleccionar imagen',
      child: Icon(Icons.add_a_photo),
    );
  }
}
