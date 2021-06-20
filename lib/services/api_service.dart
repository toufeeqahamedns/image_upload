import 'package:dio/dio.dart';
import 'package:image_upload/services/i_api_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IApiService)
class ApiService implements IApiService {
  var dio = Dio()
    ..options.baseUrl = 'http://imageupload.com/'
    ..options.connectTimeout = 45000
    ..options.receiveTimeout = 45000
    ..options.headers = {
      'token': 'xxxx',
    };

  @override
  Future<void> uploadImage(String imageBase64) async {
    final formData = FormData.fromMap({'base64': imageBase64});

    try {
      var response = await dio.post('/upload', data: formData);

      if (response.statusCode != 200) {
        throw Exception("Couldn't upload");
      }
    } catch (e) {
      throw Exception("Couldn't upload");
    }

    // Just to mock api
    await Future.delayed(Duration(milliseconds: 2000), () {
      return;
    });
  }
}
