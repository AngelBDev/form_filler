import 'package:equatable/equatable.dart';

class BillResponse extends Equatable {
  BillResponse({
    this.grossTotal = const [],
    this.itbis = const [],
    this.rnc = const [],
    this.ncf = const [],
    this.date = const [],
  });

  final List<String> ncf;
  final List<String> rnc;
  final List<DateTime> date;
  final List<num> grossTotal;
  final List<num> itbis;

  BillResponse.fromMap(Map<String, dynamic> map)
      : date = (map['fecha'] as List<String>)
            .map(
              (rawDate) => DateTime.parse(rawDate),
            )
            .toList(),
        grossTotal = map['totales'],
        itbis = map['totales'],
        ncf = map['NCF'],
        rnc = map['RNC'];

  @override
  List<Object> get props => [
        ncf,
        rnc,
        date,
        grossTotal,
        itbis,
      ];
}
