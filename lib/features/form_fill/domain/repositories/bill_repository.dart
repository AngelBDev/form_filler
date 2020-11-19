import 'package:form_filler/features/form_fill/domain/entities/bill.dart';

abstract class BillRepository {
  Future<Bill> scanBill({String base64Image});
}
