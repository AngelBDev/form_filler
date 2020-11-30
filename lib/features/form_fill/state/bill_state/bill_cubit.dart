import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/features/form_fill/data/models/bill_response.dart';
import 'package:form_filler/features/form_fill/domain/repositories/bill_repository.dart';

import 'package:meta/meta.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit({@required BillRepository billRepository})
      : _billRepository = billRepository,
        super(
          BillInitial(
            loading: false,
          ),
        );

  final BillRepository _billRepository;

  Future<BillResponse> scanBill(File image) async {
    _emitInitialState();
    _emitLoading(true);
    final response = await _tryScanBill(image);
    _emitBill(response);
    _emitLoading(false);

    return response;
  }

  Future<BillResponse> _tryScanBill(File image) async {
    BillResponse response;
    try {
      response = await _scanBill(image);
    } on DioError catch (error) {
      _handleScanBillErrors(error);
    }
    return response;
  }

  Future<BillResponse> _scanBill(File image) async {
    if (image == null) {
      throw DioError(
        error: BillErrors.null_image,
        response: Response(statusCode: 400),
        type: DioErrorType.CANCEL,
      );
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

  void _handleScanBillErrors(DioError exception) {
    _emitInitialState();
    if (exception.error == BillErrors.null_image) {
      _emitError(BillErrors.null_image);
      return;
    }

    if (exception.response.statusCode == 413) {
      _emitError(BillErrors.too_large_to_upload);
      return;
    }

    if (exception.response.statusCode != 200) {
      _emitError(BillErrors.server_error);
      return;
    }
  }

  void _emitInitialState() {
    BillInitial _state = state;
    final updatedState = _state.copyWith(
      bill: BillResponse(),
      errors: BillErrors.no_error,
      loading: false,
    );

    emit(updatedState);
  }

  void _emitLoading(bool loading) {
    BillInitial _state = state;
    _state = _state.copyWith(loading: loading);
    emit(_state);
  }

  void _emitBill(BillResponse response) {
    BillInitial _state = state;
    _state = _state.copyWith(bill: response);
    emit(_state);
  }

  void _emitError(BillErrors error) {
    BillInitial _state = state;
    _state = _state.copyWith(errors: error);
    emit(_state);
  }
}
