import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload/blocs/app_bloc_event.dart';
import 'package:image_upload/blocs/app_bloc_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late File imageFile;

  AppBloc() : super(AppState.unknown());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is CaptureImage) {
      yield* _mapCaptureImageToState();
    } else if (event is UploadImage) {
      yield* _mapUploadImageToState();
    }
  }

  Stream<AppState> _mapCaptureImageToState() async* {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      yield AppState.capturedImage();
    }
  }

  Stream<AppState> _mapUploadImageToState() async* {
    if (imageFile.lengthSync() >= 4194304) {
      // TODO: Compress and upload the image to ApiService
      yield AppState.compressingImage();
    } else {
      // TODO: Upload the image to ApiService
    }
  }
}
