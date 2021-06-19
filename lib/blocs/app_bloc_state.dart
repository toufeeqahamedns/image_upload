import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AppStatus status;

  const AppState._({this.status = AppStatus.unknown});

  const AppState.unknown() : this._();

  const AppState.capturedImage() : this._(status: AppStatus.imageCaptured);

  const AppState.compressingImage() : this._(status: AppStatus.compress);

  @override
  List<Object?> get props => [status];
}

enum AppStatus {
  unknown,
  imageCaptured,
  compress,
  upload,
}
