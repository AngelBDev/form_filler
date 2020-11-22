import 'package:dio/dio.dart';

class ServerError extends DioError {
  ServerError({
    Response response,
    RequestOptions request,
    DioErrorType type,
    dynamic error,
  }) : super(
          error: error,
          request: request,
          response: response,
          type: type,
        );

  @override
  String get message =>
      'Ha ocurrido un error inesperado en nuestros servidores, por favor intentar mas tarde.';
}
