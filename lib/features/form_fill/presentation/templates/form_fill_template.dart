import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/core/presentation/atoms/primary_button_label.dart';
import 'package:form_filler/core/presentation/hoc/focus_handler.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/molecules/form_606_variant.dart';
import 'package:form_filler/features/form_fill/state/form_606_state/form_606_cubit.dart';

class FormFillTemplate extends StatelessWidget {
  const FormFillTemplate({
    Key key,
    @required this.clientRNCController,
    @required this.periodDate,
    @required this.onTapAddBill,
    @required this.onTapBillField,
    @required this.onChangeRncField,
    @required this.onTapBillRemove,
    @required this.onSubmit,
    @required this.onChangePeriodDate,
    @required this.form606Listener,
    this.images,
    this.bills,
  }) : super(key: key);

  final List<Bill> bills;
  final List<File> images;
  final DateTime periodDate;
  final TextEditingController clientRNCController;
  final void Function() onTapAddBill;
  final void Function(String value) onChangeRncField;
  final void Function(Bill value, int index) onTapBillRemove;
  final void Function(Bill value, int index) onTapBillField;
  final void Function(BuildContext context) onSubmit;
  final void Function(DateTime date) onChangePeriodDate;
  final Function(BuildContext context, Form606State state) form606Listener;

  @override
  Widget build(BuildContext context) {
    return FocusHandler(
      child: BlocConsumer<Form606Cubit, Form606State>(
        listener: form606Listener,
        builder: (context, state) {
          final Form606Initial _state = state;

          final canSubmitForm =
              !_state.loading && !_state.downloadState.downloading;

          return Scaffold(
            appBar: _buildAppBar(
              context,
              canSubmitForm,
            ),
            body: _buildStateHandledBody(context, state),
            floatingActionButton: _buildStateHandledFloatingActionButton(
              context,
              state,
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool canPressSubmitForm) {
    final canSubmit = _canSubmit();

    return AppBar(
      elevation: 0,
      title: PrimaryButtonLabel(
        text: 'DGII 606 Formulario',
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.check,
            ),
            color: Theme.of(context).accentColor,
            disabledColor: Colors.grey.withOpacity(.4),
            onPressed: canSubmit ? () => onSubmit(context) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildStateHandledBody(BuildContext context, Form606State state) {
    Form606Initial _state = state;

    if (_state.loading) {
      return _buildLoading(context);
    }

    if (_state.downloadState.downloading) {
      return _buildDownloading(context, state);
    }

    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form606Variant(
        bills: bills,
        clientRNCController: clientRNCController,
        periodDate: periodDate,
        images: images,
        onTapAddBill: onTapAddBill,
        onChangeRncField: onChangeRncField,
        onTapBillRemove: onTapBillRemove,
        onTapBillField: onTapBillField,
        onChangePeriodDate: onChangePeriodDate,
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('...Subiendo formulario')
        ],
      ),
    );
  }

  Widget _buildDownloading(BuildContext context, Form606State state) {
    Form606Initial _state = state;

    final progress = _state.downloadState.progress;
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('Descargando archivo: $progress%')
        ],
      ),
    );
  }

  Widget _buildStateHandledFloatingActionButton(
      BuildContext context, Form606State state) {
    Form606Initial _state = state;

    if (_state.loading) return null;

    return _buildFloatingActionButton(context);
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTapAddBill,
      tooltip: 'Seleccionar imagen',
      child: Icon(Icons.add),
    );
  }

  bool _canSubmit() {
    var canSubmit = true;

    if (bills.isEmpty) canSubmit = false;
    if (periodDate.toString().trim().isEmpty) canSubmit = false;
    if (clientRNCController.text.trim().isEmpty) canSubmit = false;

    return canSubmit;
  }
}
