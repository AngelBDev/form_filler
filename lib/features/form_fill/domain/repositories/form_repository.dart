import 'package:dartz/dartz.dart';
import 'package:form_filler/core/error/failures.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';

abstract class FormRepository {
  Future<Either<Failure, Bill>> scanBill({String base64Image});
}
