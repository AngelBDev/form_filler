import 'package:equatable/equatable.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class Form606 extends Equatable {
  Form606({
    @required this.period,
    @required this.clientRNC,
    this.bills,
  });

  final DateTime period;
  final String clientRNC;
  final List<Bill> bills;

  Map<String, dynamic> toMap() {
    return {
      'period': DateFormat('yyyyMM').format(period),
      'clientRnc': clientRNC,
      'invoices': bills
          .map(
            (bill) => {
              'rnc': bill.rnc,
              'ncf': bill.ncf,
              'invoiceType': bill.transactionType,
              'date': DateFormat('yyyy/MM/dd').format(bill.date),
              'payAmount': bill.grossTotal,
              'itbis': bill.itbis,
              'invoicePaymentType': bill.paymentType,
            },
          )
          .toList()
    };
  }

  @override
  List<Object> get props => [
        period,
        clientRNC,
        bills,
      ];
}
