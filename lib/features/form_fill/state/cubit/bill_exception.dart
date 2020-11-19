import 'package:dio/dio.dart';

class NoImageToScanException implements DioError {
  NoImageToScanException({
    this.response,
    this.request,
    this.type,
    this.error,
  });

  @override
  Response response;

  @override
  DioErrorType type;

  @override
  RequestOptions request;

  @override
  String get message => 'Image != null is not true';

  @override
  var error;
}
