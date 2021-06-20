import 'package:image_upload/services/i_api_service.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class Repository {
  final IApiService _apiService;

  Repository(this._apiService);

  Future<void> uploadImage(String base64Image) async {
    return await _apiService
        .uploadImage(base64Image)
        .onError((error, stackTrace) => throw Exception(error));
  }
}
