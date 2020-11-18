import 'package:equatable/equatable.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:meta/meta.dart';

class Form606O extends Equatable {
  Form606O({@required this.period, @required this.clientRNC, this.bills});
  final String period;
  final String clientRNC;
  final List<Bill> bills;

  @override
  List<Object> get props => throw UnimplementedError();
}
