import 'package:al_huda/core/services/api_services.dart';
import '../model/hadith_model.dart';

abstract class HadithRepo {
  Future<List<HadithModel>> getHadiths({required String bookName, required int pageNumber});
}

class HadithRepoImpl implements HadithRepo {
  final ApiService apiService;
  final String apiKey = r'$2y$10$Woi3shlcGWsVP4V1atH9UusYTEAxcPBaMKEuwqnDrScJngXwj1kfW';
  final String baseUrl = 'https://hadithapi.com/api/hadiths';

  HadithRepoImpl({required this.apiService});

  @override
  Future<List<HadithModel>> getHadiths({required String bookName, required int pageNumber}) async {
    try {
      final response = await apiService.getWithoutBaseUrl(
        endpoint: baseUrl,
        query: {
          'apiKey': apiKey,
          'book': bookName,
          'page': pageNumber,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> hadithsJson = response.data['hadiths']['data'];
        return hadithsJson.map((json) => HadithModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load hadiths');
      }
    } catch (e) {
      rethrow;
    }
  }
}
