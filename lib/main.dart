import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_upload/blocs/app_bloc.dart';
import 'package:image_upload/image_upload.dart';

void main() {
  runApp(BlocProvider<AppBloc>(create: (_) => AppBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Upload Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageUpload(),
    );
  }
}
