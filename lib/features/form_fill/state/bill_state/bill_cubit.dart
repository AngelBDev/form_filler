import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/features/form_fill/data/models/bill_response.dart';
import 'package:form_filler/features/form_fill/domain/repositories/bill_repository.dart';
import 'package:form_filler/features/form_fill/state/bill_state/bill_exception.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit(this._billRepository) : super(BillInitial());
  final BillRepository _billRepository;

  void scanBill(File image) {
    BillInitial _state = state;
    _state = _state.copyWith(loading: true);
    emit(_state);
    _tryScanBill(image);
  }

  void _tryScanBill(File image) async {
    BillInitial _state = state;
    try {
      final response = await _scanBill(image);

      _state = _state.copyWith(bill: response);
      emit(_state);
    } on DioError catch (error) {
      _handleScanBillErrors(error);
    }
  }

  Future<BillResponse> _scanBill(File image) async {
    if (image == null) {
      throw NoImageToScanException();
    }

    final base64Image = await _convertFileToBase64(image);

    final response = await _billRepository.scanBill(base64Image: base64Image);

    return response;
  }

  Future<String> _convertFileToBase64(File file) async {
    final binary = await file.readAsBytes();
    final base64File = base64Encode(binary);

    return base64File;
  }

  void _handleScanBillErrors(DioError err) {
    BillInitial _state = state;
    if (err is NoImageToScanException) {
      _state = _state.copyWith(errors: BillErrors.null_image);
      emit(_state);
    }

    if (err.response.statusCode != 200) {
      _state = _state.copyWith(errors: BillErrors.server_error);
      emit(_state);
    }
  }
}
