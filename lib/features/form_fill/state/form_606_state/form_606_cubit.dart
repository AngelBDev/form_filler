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
    @required this.form606Repository,
  }) : super(
          Form606Initial(
            errors: null,
            loading: false,
            downloadState: initialDownloadState,
          ),
        );

  final Form606Repository form606Repository;

  void submitForm({@required Form606 form}) async {
    Form606Initial _state = state;
    _state = _state.copyWith(loading: true);
    emit(_state);
    await _trySubmitForm(form: form);
    _state = _state.copyWith(loading: false);
    emit(_state);
  }

  Future<void> _trySubmitForm({@required Form606 form}) async {
    try {
      await _submitForm(form: form);
    } on DioError catch (error) {
      _handleSubmitFormErrors(error);
    }
  }

  Future<void> _submitForm({@required Form606 form}) async {
    final codeName = await form606Repository.submit(form: form);

    await form606Repository.downloadFormFile(
      codename: codeName,
      downloadPath: await _getDownloadPath(),
      onReceiveProgress: _onReceiveProgress,
    );
  }

  Future<String> _getDownloadPath() async {
    final downloadDirectory = await getExternalStorageDirectory();
    final path = downloadDirectory.path;
    return path;
  }

  void _onReceiveProgress(received, total) {
    Form606Initial _state = state;
    final double progressInPercentage = (received / total * 100);
    final updatedDownloadState = _state.downloadState.copyWith(
      progress: progressInPercentage,
      total: total,
      downloading: true,
    );
    _state = _state.copyWith(downloadState: updatedDownloadState);
    emit(_state);
    return;
  }

  void _handleSubmitFormErrors(DioError error) {
    Form606Initial _state = state;

    if (error.response.statusCode != 200) {
      _state = _state.copyWith(errors: FormErrors.server_error);
      emit(_state);
    }
  }
}

final initialDownloadState = DownloadState(
  downloading: false,
  progress: 0,
  total: 0,
);
