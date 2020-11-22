import 'package:dio/dio.dart';
import 'package:form_filler/core/utils/enviroment.dart';
import 'package:form_filler/features/form_fill/data/models/bill_response.dart';

abstract class BillRepository {
  BillRepository({
    this.dio,
    this.env,
  });

  final Dio dio;
  final Enviroment env;

  Future<BillResponse> scanBill({String base64Image});
}
