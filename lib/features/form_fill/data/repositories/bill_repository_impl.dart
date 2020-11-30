import 'package:dio/dio.dart';
import 'package:form_filler/core/utils/enviroment.dart';
import 'package:form_filler/features/form_fill/data/models/bill_response.dart';
import 'package:form_filler/features/form_fill/domain/repositories/bill_repository.dart';
import 'package:meta/meta.dart';

class BillRepositoryImpl implements BillRepository {
  BillRepositoryImpl({
    @required this.dio,
    @required this.env,
  });

  @override
  final Dio dio;

  @override
  final Enviroment env;

  @override
  Future<BillResponse> scanBill({String base64Image}) async {
    final body = {
      'base64': [
        'data:image/jpeg;base64,$base64Image',
      ]
    };
    final response = await dio.post(
      '${env.apiUrl}/ocr',
      data: body,
    );
    final Map<String, dynamic> data = response.data[0];

    final bill = BillResponse.fromMap(data);

    return bill;
  }
}
