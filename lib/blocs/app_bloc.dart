import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload/blocs/app_bloc_event.dart';
import 'package:image_upload/blocs/app_bloc_state.dart';
import 'package:image_upload/repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late File imageFile;

  final Repository repository;

  AppBloc(this.repository) : super(AppState.unknown());

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
      yield AppState.compressingImage();
      try {
        File compressedFile = await _reduceImageSize(imageFile);

        yield AppState.uploadingImage();

        yield* _uploadImage(compressedFile);
      } catch (e) {
        yield AppState.compressError();
      }
    } else {
      yield AppState.uploadingImage();

      yield* _uploadImage(imageFile);
    }
  }

  Stream<AppState> _uploadImage(File fileToUpload) async* {
    try {
      final base64Image = base64Encode(fileToUpload.readAsBytesSync());

      await repository.uploadImage(base64Image);
      yield AppState.uploadedImage();
    } catch (e) {
      yield AppState.uploadError();
    }
  }

  Future<File> _reduceImageSize(File fileToCompress) async {
    File file = await FlutterNativeImage.compressImage(
      fileToCompress.path,
    );

    if (file.lengthSync() >= 4194304) {
      return _reduceImageSize(file);
    }
    return file;
  }
}
