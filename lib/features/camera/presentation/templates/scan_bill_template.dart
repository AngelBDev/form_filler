import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/core/presentation/atoms/primary_button.dart';
import 'package:form_filler/core/presentation/atoms/primary_button_label.dart';
import 'package:form_filler/features/camera/presentation/atoms/image_display.dart';
import 'package:form_filler/features/form_fill/state/bill_state/bill_cubit.dart';
import 'package:image_picker/image_picker.dart';

class ScanBillTemplate extends StatelessWidget {
  const ScanBillTemplate({
    Key key,
    @required this.scanBill,
    @required this.getImage,
    @required this.stateListener,
    this.image,
  }) : super(key: key);

  final File image;

  final void Function(File) scanBill;

  final void Function(ImageSource) getImage;

  final void Function(BuildContext, BillState) stateListener;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillCubit, BillState>(
      listener: stateListener,
      builder: (context, state) {
        BillInitial _state = state;
        return Scaffold(
          appBar: _buildAppBar(
            context,
            !_state.loading,
          ),
          body: _buildStateHandledBody(
            context,
            state,
          ),
          floatingActionButton: _buildStateHandledFloatingActionButton(
            context,
            state,
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, bool canPressScanBill) {
    return AppBar(
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.check,
          ),
          disabledColor: Colors.grey,
          onPressed: canPressScanBill ? () => scanBill(image) : null,
        )
      ],
    );
  }

  Widget _buildStateHandledBody(BuildContext context, BillState state) {
    BillInitial _state = state;

    if (_state.loading) {
      return _builBodydLoading(context, state);
    }

    return _buildBody(context);
  }

  Widget _builBodydLoading(BuildContext context, BillState state) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('...Escaneando foto')
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            ImageDisplay(image: image),
            SizedBox(height: 20),
            _buildControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Wrap(
      spacing: 30,
      children: [
        Container(
          width: 120,
          child: PrimaryButton(
            onPressed: () => getImage(ImageSource.camera),
            child: Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                PrimaryButtonLabel(text: 'Camara'),
              ],
            ),
          ),
        ),
        Container(
          width: 120,
          child: PrimaryButton(
            onPressed: () => getImage(ImageSource.gallery),
            child: Row(
              children: [
                Icon(
                  Icons.photo_library,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                PrimaryButtonLabel(text: 'Galleria'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStateHandledFloatingActionButton(
      BuildContext context, BillState state) {
    BillInitial _state = state;

    if (_state.loading) return null;

    return _buildFloatingActionButton();
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => scanBill(image),
      child: Icon(Icons.scanner_sharp),
    );
  }
}
