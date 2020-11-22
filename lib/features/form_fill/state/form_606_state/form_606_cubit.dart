import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/features/form_fill/domain/entities/form_606.dart';
import 'package:form_filler/features/form_fill/domain/repositories/form_606_repository.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'form_606_state.dart';

class Form606Cubit extends Cubit<Form606State> {
  Form606Cubit({@required this.form606Repository}) : super(Form606Initial());

  final Form606Repository form606Repository;

  void submitForm({@required Form606 form}) {
    _trySubmitForm(form: form);
  }

  Future<void> _trySubmitForm({@required Form606 form}) async {
    try {
      await _submitForm(form: form);
    } on DioError catch (error) {}
  }

  Future<void> _submitForm({@required Form606 form}) async {
    final codeName = await form606Repository.submit(form: form);

    await form606Repository.downloadFormFile(
      codename: codeName,
      downloadPath: await _getDownloadPath(),
      onReceiveProgress: _onReceiveProgress,
    );
  }

  Future<String> _getDownloadPath() async {
    final downloadDirectory = await getExternalStorageDirectory();
    final path = downloadDirectory.path;
    return path;
  }

  int _onReceiveProgress(received, total) {}

  void _onSubmit(Map<String, dynamic> data) async {
    /*  final data = {
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
    }; */

    /*   Response<dynamic> result;

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
    } */
  }
}
