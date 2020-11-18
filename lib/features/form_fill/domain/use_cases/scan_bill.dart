import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/core/error/failures.dart';
import 'package:form_filler/core/use_case/use_case.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/domain/repositories/form_repository.dart';
import 'package:meta/meta.dart';

class ScanBill extends UseCase<Bill, ScanBillParams> {
  ScanBill({
    @required this.repository,
  });

  final FormRepository repository;

  @override
  Future<Either<Failure, Bill>> call(ScanBillParams params) async {
    final base64Image = params.base64Image;
    final result = await repository.scanBill(base64Image: base64Image);

    return result;
  }
}

class ScanBillParams extends Equatable {
  ScanBillParams({
    this.base64Image,
  });
  final String base64Image;

  @override
  List<Object> get props => [
        base64Image,
      ];
}
