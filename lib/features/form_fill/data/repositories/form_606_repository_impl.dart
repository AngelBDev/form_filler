import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:form_filler/core/utils/enviroment.dart';
import 'package:form_filler/features/form_fill/domain/entities/form_606.dart';
import 'package:form_filler/features/form_fill/domain/repositories/form_606_repository.dart';
import 'package:form_filler/features/form_fill/state/form_606_state/form_606_exception.dart';
import 'package:meta/meta.dart';

class Form606RepositoryImpl implements Form606Repository {
  Form606RepositoryImpl({
    this.dio,
    this.env,
  });
  @override
  final Dio dio;

  @override
  final Enviroment env;

  @override
  Future<String> submit({Form606 form}) async {
    final body = form.toMap();

    final response = await dio.post<Map<String, dynamic>>(
      '${env.apiUrl}/excel/fill',
      data: body,
    );

    _validate(response);

    return response.data['codeName'];
  }

  @override
  Future<void> downloadFormFile({
    @required String downloadPath,
    @required String codename,
    @required void Function(int, int) onReceiveProgress,
  }) async {
    final name = 'Excel form - ${DateTime.now()}';
    final url = '${env.apiUrl}/excel/file/codename';
    final savePath = '$downloadPath/Documents/${name}.xls';
    final options = Options(
      headers: {
        HttpHeaders.acceptEncodingHeader: '*',
      },
    );
    final response = await dio.download(
      url,
      savePath,
      options: options,
      onReceiveProgress: onReceiveProgress,
    );

    _validate(response);
  }

  void _validate(Response<Map<String, dynamic>> response) {
    if (response.statusCode != 200 || response.data['codeName'] == null) {
      throw ServerError(
        type: DioErrorType.DEFAULT,
        response: response,
        request: response.request,
        error:
            'Ha ocurrido un error inesperado creando su factura, por favor intentar mas tarde',
      );
    }
  }
}
