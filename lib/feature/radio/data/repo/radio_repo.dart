import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/data/exeptions/api_error_handeler.dart';
import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/services/api_services.dart';

class RadioRepo {
  final ApiService apiService;

  RadioRepo(this.apiService);

  Future<ApiResponse> getRadio() async {
    try {
      var response = await apiService.getWithoutBaseUrl(endpoint: AppURL.radio);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
