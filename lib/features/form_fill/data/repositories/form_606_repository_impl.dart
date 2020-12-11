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

    _validateForm(response);

    return response.data['codeName'];
  }

  void _validateForm(Response<dynamic> response) {
    _checkStatusCode(response);
    _checkCodeName(response);
  }

  @override
  Future<void> downloadFormFile({
    @required String downloadPath,
    @required String codename,
    @required String period,
    @required void Function(int, int) onReceiveProgress,
  }) async {
    final name =
        'Excel form - ${DateTime.now().toString()} .$codename .$period';
    final url = '${env.apiUrl}/excel/file/$codename';
    final savePath = '$downloadPath/Documents/${name}.xls';

    final response = await dio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
    );

    _validateDownload(response);
  }

  void _validateDownload(Response<dynamic> response) {
    _checkStatusCode(response);
  }

  void _checkStatusCode(Response<dynamic> response) {
    if (response.statusCode != 200) {
      _throwServerError(response);
    }
  }

  void _checkCodeName(Response<dynamic> response) {
    if (response.data['codeName'] == null) {
      _throwServerError(response);
    }
  }

  void _throwServerError(Response<dynamic> response) {
    throw ServerError(
      type: DioErrorType.DEFAULT,
      response: response,
      request: response.request,
      error:
          'Ha ocurrido un error inesperado creando su factura, por favor intentar mas tarde',
    );
  }
}
