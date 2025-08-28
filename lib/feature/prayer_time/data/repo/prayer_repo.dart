import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/data/exeptions/api_error_handeler.dart';
import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/services/api_services.dart';

class PrayerRepo {
  ApiService apiService;

  PrayerRepo(this.apiService);
  Future<ApiResponse> getPrayerTime(String latitude, String longitude) async {
    try {
      final response = await apiService.getWithoutBaseUrl(
        endpoint:
            '${AppURL.prayer}latitude=$latitude&longitude=$longitude&method=8',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

// https://api.aladhan.com/v1/timings/26-08-2025?latitude=30.0444&longitude=31.2357&method=8
