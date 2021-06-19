import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_upload/blocs/app_bloc.dart';
import 'package:image_upload/image_upload.dart';
import 'package:image_upload/main.config.dart';
import 'package:image_upload/repository.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
void configureInjection() => $initGetIt(getIt);
void main() {
  configureInjection();
  runApp(BlocProvider<AppBloc>(
      create: (_) => AppBloc(getIt<Repository>()), child: MyApp()));
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
