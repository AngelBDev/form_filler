import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/templates/bill_form_template.dart';

class BillFormScreen extends StatefulWidget {
  static const route = 'bill-form';
  BillFormScreen({Key key}) : super(key: key);

  @override
  _BillFormScreenState createState() => _BillFormScreenState();
}

class _BillFormScreenState extends State<BillFormScreen> {
  TextEditingController _rncController;
  TextEditingController _ncfController;
  TextEditingController _grossTotalController;
  TextEditingController _itbisController;
  int _transactionType;
  int _paymentType;
  DateTime _date;
  File _image;
  Bill _bill;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final BillFormScreenParams arguments =
        ModalRoute.of(context).settings.arguments;
    _image = arguments.image;
    _bill = arguments.bill;
    _transactionType = _bill?.transactionType;
    _paymentType = _bill?.paymentType;
    _date = _bill?.date;
    _rncController = TextEditingController(text: _bill?.rnc);
    _ncfController = TextEditingController(text: _bill?.ncf);
    _itbisController = TextEditingController(
      text: _bill?.itbis?.toString(),
    );
    _grossTotalController = TextEditingController(
      text: _bill?.grossTotal?.toString(),
    );
  }

  @override
  void dispose() {
    _rncController?.dispose();
    _ncfController?.dispose();
    _grossTotalController?.dispose();
    _itbisController?.dispose();

    super.dispose();
  }

  void _onChangeTransactionType(int value) {
    setState(() {
      _transactionType = value;
    });
  }

  void _onTapTransactionType() {}

  void _onChangePaymentType(int value) {
    setState(() {
      _paymentType = value;
    });
  }

  void _onTapPaymentType() {}

  void _onChangeDate(DateTime value) {
    setState(() {
      _date = value;
    });
  }

  void _onSubmit() {
    final bill = Bill(
      date: _date,
      grossTotal: int.tryParse(_grossTotalController.text),
      itbis: int.tryParse(_itbisController.text),
      transactionType: _transactionType,
      ncf: _ncfController.text,
      rnc: _rncController.text,
      paymentType: _paymentType,
    );

    Navigator.of(context).pop(bill);
  }

  void _scanImage(image) async {
    if (image != null) {
      final imageBinary = await image.readAsBytes();
      final base64Image = base64Encode(imageBinary);

      final body = {
        'base64': [
          'data:image/jpeg;base64,$base64Image',
        ]
      };

      print('asdf');
      try {
        final response =
            await Dio().post('https://6a6f3c5d8653.ngrok.io/ocr', data: body);

        final data = response.data[0];

        final bill = Bill(
          date: data['fecha'].isNotEmpty
              ? DateTime.parse(data['fecha'][0])
              : null,
          grossTotal: data['totales'].length > 1 ? data['totales'][1] : null,
          itbis: data['totales'].length >= 1 ? data['totales'][0] : null,
          ncf: data['NCF'].isNotEmpty ? data['NCF'].first : null,
          rnc: data['RNC'].length > 1 ? data['RNC'][1] : null,
        );

        setState(() {
          _ncfController.text = bill.ncf ?? _ncfController.text;
          _rncController.text = bill.rnc ?? _rncController.text;
          _grossTotalController.text =
              '${bill.grossTotal}' ?? _grossTotalController.text;
          _itbisController.text =
              bill?.itbis?.toString() ?? _itbisController.text;

          _date = bill.date ?? _date;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BillFormTemplate(
      bill: _bill,
      image: _image,
      rncController: _rncController,
      ncfController: _ncfController,
      grossTotalController: _grossTotalController,
      itbisController: _itbisController,
      date: _date,
      paymentType: _paymentType,
      transactionType: _transactionType,
      onChangePaymentType: _onChangePaymentType,
      onTapPaymentType: _onTapPaymentType,
      onChangeTransactionType: _onChangeTransactionType,
      onTapTransactionType: _onTapTransactionType,
      onChangeDate: _onChangeDate,
      onSubmit: _onSubmit,
      scanImage: _scanImage,
    );
  }
}

class BillFormScreenParams extends Equatable {
  final Bill bill;
  final File image;

  BillFormScreenParams({this.bill, this.image});

  @override
  List<Object> get props => [bill, image];
}
