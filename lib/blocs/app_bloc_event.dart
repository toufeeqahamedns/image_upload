import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class CaptureImage extends AppEvent {
  @override
  List<Object?> get props => [];
}

class UploadImage extends AppEvent {
  @override
  List<Object?> get props => [];
}
