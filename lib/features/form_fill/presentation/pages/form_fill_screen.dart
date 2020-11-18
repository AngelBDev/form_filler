import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/pages/bill_form_screen.dart';
import 'package:form_filler/features/form_fill/presentation/templates/form_fill_template.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FormFillScreen extends StatefulWidget {
  static const route = 'form';
  const FormFillScreen({Key key}) : super(key: key);

  @override
  _FormFillScreenState createState() => _FormFillScreenState();
}

class _FormFillScreenState extends State<FormFillScreen> {
  final TextEditingController _clientRNCController = TextEditingController();
  DateTime _periodDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _clientRNCController.addListener(() {
      setState(() {});
    });
  }

  final List<Bill> _bills = [];

  List<File> _images;

  @override
  void dispose() {
    _clientRNCController.dispose();
    super.dispose();
  }

  void _onTapAddBill() {
    _onTapBillField();
  }

  void _onTapBillField([Bill value]) async {
    final bill = await Navigator.of(context).pushNamed(
      BillFormScreen.route,
      arguments: BillFormScreenParams(bill: value),
    );
    _addBill(bill);
  }

  void _addBill(Bill value) {
    if (value != null) {
      setState(() {
        _bills.add(value);
      });
    }
  }

  void _onTapBillRemove(Bill value, int index) {
    setState(() {
      _bills.remove(value);
    });
  }

  void _onSubmit(BuildContext context) async {
    var data = {
      'period': DateFormat('yyyyMM').format(_periodDate),
      'clientRnc': _clientRNCController.text,
      'invoices': _bills
          .map(
            (bill) => {
              'rnc': bill.rnc,
              'ncf': bill.ncf,
              'invoiceType': bill.transactionType,
              'date': DateFormat('yyyy/MM/dd').format(bill.date),
              'payAmount': bill.grossTotal,
              'itbis': bill.itbis,
              'invoicePaymentType': bill.paymentType,
            },
          )
          .toList()
    };

    print('asdfsda');
    Response<dynamic> result;

    try {
      result = await Dio().post(
        'https://6a6f3c5d8653.ngrok.io/excel/fill',
        data: data,
      );

      print(result);
    } catch (e) {
      print(e);
    }

    if (result != null && result.data['result'] == 2) {
      final snackBar = SnackBar(
        content: Text('ha ocurrido un error!'),
        backgroundColor: Colors.red,
      );

      Scaffold.of(context).showSnackBar(snackBar);
    } else if (result != null && result.data['result'] == 1) {
      final downloadsDirectory = await getExternalStorageDirectory();
      try {
        final name = Uuid().v1();
        final response = await Dio().download(
            'https://6a6f3c5d8653.ngrok.io/excel/file/${result.data['codeName']}',
            '${downloadsDirectory.path}/Documents/${name}.xls');
        print('full path ${downloadsDirectory.path}/Images/${name}.xls');

        if (response.statusCode == 200) {
          final snackBar = SnackBar(
            content: Text('Tu archivo ha sido creado!'),
            backgroundColor: Colors.green,
          );

          Scaffold.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormFillTemplate(
      bills: _bills,
      images: _images,
      clientRNCController: _clientRNCController,
      periodDate: _periodDate,
      onChangePeriodDate: _onChangePeriodDate,
      onTapAddBill: _onTapAddBill,
      onTapBillField: _onTapBillField,
      onTapBillRemove: _onTapBillRemove,
      onSubmit: _onSubmit,
    );
  }

  void _onChangePeriodDate(date) {
    setState(() {
      _periodDate = date;
    });
  }
}
