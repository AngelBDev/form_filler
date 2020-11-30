import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/features/form_fill/domain/entities/form_606.dart';
import 'package:form_filler/features/form_fill/domain/repositories/form_606_repository.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'form_606_state.dart';

class Form606Cubit extends Cubit<Form606State> {
  Form606Cubit({
    @required Form606Repository form606Repository,
  })  : _form606Repository = form606Repository,
        super(
          Form606Initial(
            errors: null,
            loading: false,
            downloadState: initialDownloadState,
          ),
        );

  final Form606Repository _form606Repository;

  void submitForm({@required Form606 form}) async {
    _emitInitialState();
    _emitLoading(true);
    await _trySubmitForm(form: form);
  }

  Future<void> _trySubmitForm({@required Form606 form}) async {
    try {
      await _submitForm(form: form);
    } on DioError catch (error) {
      _handleSubmitFormErrors(error);
    }
  }

  Future<void> _submitForm({@required Form606 form}) async {
    final codeName = await _form606Repository.submit(form: form);
    await _dowloadFile(codeName);
  }

  Future _dowloadFile(String codeName) async {
    _emitLoading(false);
    _emitDownload(downloading: true);
    await _form606Repository.downloadFormFile(
      codename: codeName,
      downloadPath: await _getDownloadPath(),
      onReceiveProgress: _onReceiveProgress,
    );
    _emitInitialState();
  }

  Future<String> _getDownloadPath() async {
    final downloadDirectory = await getExternalStorageDirectory();
    final path = downloadDirectory.path;
    return path;
  }

  void _onReceiveProgress(int received, int total) {
    final progressInPercentage = (received / total * 100).ceil();
    final totalInPercentage = 100;
    _emitDownload(progress: progressInPercentage, total: totalInPercentage);

    return;
  }

  void _handleSubmitFormErrors(DioError exception) {
    _emitInitialState();
    if (exception?.response?.statusCode != 200) {
      _emitError(FormErrors.server_error);
    }
  }

  void _emitInitialState() {
    Form606Initial _state = state;
    final _downloadState = DownloadState(
      downloading: false,
      progress: 0,
      total: 0,
    );
    final updatedState = _state.copyWith(
      loading: false,
      errors: FormErrors.no_error,
      downloadState: _downloadState,
    );
    emit(updatedState);
  }

  void _emitLoading(bool loading) {
    Form606Initial _state = state;
    _state = _state.copyWith(
      loading: loading,
    );
    emit(_state);
  }

  void _emitDownload({bool downloading, int progress, int total}) {
    Form606Initial _state = state;
    final _downloadState = _state.downloadState.copyWith(
      downloading: downloading,
      progress: progress,
      total: total,
    );
    final updatedState = _state.copyWith(
      downloadState: _downloadState,
    );
    emit(updatedState);
  }

  void _emitError(FormErrors errors) {
    Form606Initial _state = state;
    _state = _state.copyWith(errors: errors);
    emit(_state);
  }
}

final initialDownloadState = DownloadState(
  downloading: false,
  progress: 0,
  total: 0,
);
