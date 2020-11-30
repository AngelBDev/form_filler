part of 'form_606_cubit.dart';

abstract class Form606State extends Equatable {
  const Form606State();

  @override
  List<Object> get props => [];
}

class Form606Initial extends Form606State {
  Form606Initial({
    @required this.errors,
    @required this.loading,
    @required this.downloadState,
  });

  final FormErrors errors;
  final bool loading;
  final DownloadState downloadState;

  Form606Initial copyWith({
    FormErrors errors,
    bool loading,
    DownloadState downloadState,
  }) {
    return Form606Initial(
      errors: errors == FormErrors.no_error ? null : errors ?? this.errors,
      loading: loading ?? this.loading,
      downloadState: downloadState ?? this.downloadState,
    );
  }

  @override
  List<Object> get props => [errors, loading, downloadState];
}

class DownloadState extends Equatable {
  DownloadState({
    @required this.progress,
    @required this.total,
    @required this.downloading,
  });

  final int progress;
  final int total;
  final bool downloading;

  @override
  List<Object> get props => [progress, total, downloading];

  DownloadState copyWith({
    int progress,
    int total,
    bool downloading,
  }) {
    return DownloadState(
      progress: progress ?? this.progress,
      total: total ?? this.total,
      downloading: downloading ?? this.downloading,
    );
  }
}

enum FormErrors {
  server_error,
  dowload_error,
  no_error,
}
