import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/data/exeptions/api_error_handeler.dart';
import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/services/api_services.dart';

class AyatRepo {
  ApiService apiService;
  AyatRepo(this.apiService);
  Future<ApiResponse> getAyat(int surahNumber, String readerName) async {
    try {
      final response = await apiService.get(
        endpoint: '${AppURL.surah}/$surahNumber/$readerName',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
