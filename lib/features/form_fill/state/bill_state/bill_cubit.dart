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

  Future<BillResponse> scanBill(File image) async {
    _emitLoading(true);
    final response = await _tryScanBill(image);
    _emitLoading(false);
    return response;
  }

  void _emitLoading(bool loading) {
    BillInitial _state = state;
    _state.copyWith(loading: loading);
    emit(_state);
  }

  Future<BillResponse> _tryScanBill(File image) async {
    BillResponse response;
    try {
      response = await _scanBill(image);
      _emitBill(response);
    } on DioError catch (error) {
      _handleScanBillErrors(error);
    }
    return response;
  }

  void _emitBill(BillResponse response) {
    BillInitial _state = state;
    _state = _state.copyWith(bill: response);
    emit(_state);
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

  void _handleScanBillErrors(DioError error) {
    BillInitial _state = state;
    if (error is NoImageToScanException) {
      _state = _state.copyWith(errors: BillErrors.null_image);
      emit(_state);
    }

    if (error.response.statusCode != 200) {
      _state = _state.copyWith(errors: BillErrors.server_error);
      emit(_state);
    }
  }
}
