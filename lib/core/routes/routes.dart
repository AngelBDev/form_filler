import 'package:flutter/material.dart';
import 'package:form_filler/features/camera/presentation/pages/scan_bill_screen.dart';
import 'package:form_filler/features/form_fill/presentation/pages/bill_form_screen.dart';
import 'package:form_filler/features/form_fill/presentation/pages/form_fill_screen.dart';
import 'package:form_filler/features/history/presentation/screens/history_screen.dart';

final Map<String, WidgetBuilder> routes = {
  FormFillScreen.route: (context) => FormFillScreen(),
  BillFormScreen.route: (context) => BillFormScreen(),
  ScanBillScreen.route: (context) => ScanBillScreen(),
  HistoryScreen.route: (context) => HistoryScreen(),
};
