import 'package:dio/dio.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/domain/repositories/bill_repository.dart';

class BillRepositoryImpl implements BillRepository {
  final dio = Dio();

  @override
  Future<Bill> scanBill({String base64Image}) async {
    final body = {
      'base64': [
        'data:image/jpeg;base64,$base64Image',
      ]
    };
    final response = await dio.post<Map<String, dynamic>>(
      'https://6a6f3c5d8653.ngrok.io/ocr',
      data: body,
    );
    final Map<String, dynamic> data = response.data[0];
    final bill = Bill.fromMap(data);

    return bill;
  }
}
