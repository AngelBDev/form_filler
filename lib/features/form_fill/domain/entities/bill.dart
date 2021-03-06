import 'package:equatable/equatable.dart';

class Bill extends Equatable {
  Bill({
    this.grossTotal,
    this.itbis,
    this.transactionType,
    this.paymentType,
    this.rnc,
    this.ncf,
    this.date,
  });

  final String ncf;
  final String rnc;
  final DateTime date;
  final double grossTotal;
  final double itbis;
  final int transactionType;
  final int paymentType;

  Bill copyWith({
    String ncf,
    String rnc,
    DateTime date,
    double grossTotal,
    double itbis,
    int transactionType,
    int paymentType,
  }) {
    return Bill(
      ncf: ncf ?? this.ncf,
      rnc: rnc ?? this.rnc,
      date: date ?? this.date,
      grossTotal: grossTotal ?? this.grossTotal,
      itbis: itbis ?? this.itbis,
      transactionType: transactionType ?? this.transactionType,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  @override
  List<Object> get props => [
        ncf,
        rnc,
        date,
        grossTotal,
        itbis,
        transactionType,
        paymentType,
      ];
}
