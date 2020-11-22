part of 'bill_cubit.dart';

abstract class BillState extends Equatable {
  const BillState();

  @override
  List<Object> get props => [];
}

class BillInitial extends BillState with EquatableMixin {
  BillInitial({this.bill, this.errors, this.loading});

  final BillResponse bill;
  final BillErrors errors;
  final bool loading;

  @override
  List<Object> get props => [bill, errors];

  BillInitial copyWith({
    BillResponse bill,
    BillErrors errors,
    bool loading,
  }) {
    return BillInitial(
      bill: bill ?? this.bill,
      errors: errors ?? this.errors,
      loading: loading ?? this.loading,
    );
  }
}

enum BillErrors {
  null_image,
  server_error,
  not_enough_info,
}
