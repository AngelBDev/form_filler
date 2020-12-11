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
      : date = List<String>.from(map['fecha'])
            .map(
              (rawDate) => DateTime.parse(rawDate),
            )
            .toList(),
        grossTotal = List<num>.from(map['totales']),
        itbis = List<num>.from(map['totales']),
        ncf = List<String>.from(map['NCF']),
        rnc = List<String>.from(map['RNC']);

  @override
  List<Object> get props => [
        ncf,
        rnc,
        date,
        grossTotal,
        itbis,
      ];

  BillResponse copyWith({
    List<String> ncf,
    List<String> rnc,
    List<DateTime> date,
    List<num> grossTotal,
    List<num> itbis,
  }) {
    return BillResponse(
      ncf: ncf ?? this.ncf,
      rnc: rnc ?? this.rnc,
      date: date ?? this.date,
      grossTotal: grossTotal ?? this.grossTotal,
      itbis: itbis ?? this.itbis,
    );
  }
}
