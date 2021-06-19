import 'package:flutter/material.dart';
import 'package:image_upload/blocs/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_upload/blocs/app_bloc_event.dart';
import 'package:image_upload/blocs/app_bloc_state.dart';

class ImageUpload extends StatelessWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
      ),
      body: Center(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (BuildContext context, AppState state) {
            switch (state.status) {
              case AppStatus.imageCaptured:
                return Text(
                  "Image Captured at location ${context.watch<AppBloc>().imageFile}",
                  textAlign: TextAlign.center,
                );
              case AppStatus.compressing:
                return Text("Compressing Image...");
              case AppStatus.uploading:
                return Text("Uploading Image...");
              case AppStatus.uploading:
                return Text("Uploaded Image");
              case AppStatus.unknown:
              default:
                return Text("Click Image to Upload");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: (context.watch<AppBloc>().state.status == AppStatus.unknown ||
                context.watch<AppBloc>().state.status == AppStatus.uploaded)
            ? Icon(Icons.camera_alt)
            : Icon(Icons.upload),
        onPressed: () {
          if (context.read<AppBloc>().state.status == AppStatus.unknown ||
              context.read<AppBloc>().state.status == AppStatus.uploaded) {
            context.read<AppBloc>().add(CaptureImage());
          } else {
            context.read<AppBloc>().add(UploadImage());
          }
        },
      ),
    );
  }
}
