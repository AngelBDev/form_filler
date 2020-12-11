import 'package:dio/dio.dart';
import 'package:form_filler/core/utils/enviroment.dart';
import 'package:form_filler/features/form_fill/domain/entities/form_606.dart';
import 'package:meta/meta.dart';

abstract class Form606Repository {
  Form606Repository({
    @required this.dio,
    @required this.env,
  });

  final Dio dio;
  final Enviroment env;

  Future<String> submit({
    @required Form606 form,
  });

  Future<void> downloadFormFile({
    @required String downloadPath,
    @required String codename,
    @required String period,
    @required void Function(int, int) onReceiveProgress,
  });
}
