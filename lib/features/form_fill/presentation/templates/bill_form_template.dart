import 'package:flutter/material.dart';

import 'package:form_filler/core/presentation/hoc/focus_handler.dart';

import 'package:form_filler/features/form_fill/data/models/bill_response.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/molecules/bill_form.dart';

class BillFormTemplate extends StatefulWidget {
  const BillFormTemplate({
    Key key,
    @required this.bill,
    @required this.billResponse,
    @required this.rncController,
    @required this.ncfController,
    @required this.grossTotalController,
    @required this.itbisController,
    @required this.onPressedRncOption,
    @required this.onPressedNcfOption,
    @required this.onPressedGrossTotalOption,
    @required this.onPressedItbisOption,
    @required this.onPressedDateOption,
    @required this.onChangePaymentType,
    @required this.onTapTransactionType,
    @required this.onTapPaymentType,
    @required this.onChangeTransactionType,
    @required this.onChangeDate,
    @required this.onSubmit,
    @required this.navigateAndScanBill,
  }) : super(key: key);

  final Bill bill;
  final BillResponse billResponse;
  final TextEditingController rncController;
  final TextEditingController ncfController;
  final TextEditingController grossTotalController;
  final TextEditingController itbisController;
  final void Function(String) onPressedRncOption;
  final void Function(String) onPressedNcfOption;
  final void Function(num) onPressedGrossTotalOption;
  final void Function(num) onPressedItbisOption;
  final void Function(DateTime) onPressedDateOption;
  final void Function() onTapPaymentType;
  final void Function(int value) onChangeTransactionType;
  final void Function(int value) onChangePaymentType;
  final void Function() onTapTransactionType;
  final void Function(DateTime date) onChangeDate;
  final void Function(Bill bill) onSubmit;
  final void Function() navigateAndScanBill;

  @override
  _BillFormTemplateState createState() => _BillFormTemplateState();
}

class _BillFormTemplateState extends State<BillFormTemplate> {
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
        IconButton(
          icon: Icon(Icons.check, color: Colors.black),
          onPressed: isFormFilled ? () => widget.onSubmit(widget.bill) : null,
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
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: BillForm(
                  bill: widget.bill,
                  billResponse: widget.billResponse,
                  rncController: widget.rncController,
                  ncfController: widget.ncfController,
                  grossTotalController: widget.grossTotalController,
                  itbisController: widget.itbisController,
                  date: widget.bill?.date,
                  transactionType: widget.bill?.transactionType,
                  paymentType: widget.bill?.paymentType,
                  onPressedRncOption: widget.onPressedRncOption,
                  onPressedNcfOption: widget.onPressedNcfOption,
                  onPressedGrossTotalOption: widget.onPressedGrossTotalOption,
                  onPressedItbisOption: widget.onPressedItbisOption,
                  onPressedDateOption: widget.onPressedDateOption,
                  onChangePaymentType: widget.onChangePaymentType,
                  onTapPaymentType: widget.onTapPaymentType,
                  onChangeTransactionType: widget.onChangeTransactionType,
                  onTapTransactionType: widget.onTapTransactionType,
                  onChangeDate: widget.onChangeDate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.navigateAndScanBill,
      tooltip: 'Seleccionar imagen',
      child: Icon(Icons.add_a_photo),
    );
  }
}
