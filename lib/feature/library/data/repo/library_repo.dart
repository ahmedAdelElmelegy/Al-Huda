import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/library_models.dart';

class LibraryRepo {
  List<CategoryModel>? _categories;
  List<ArticleModel>? _prophetArticles;
  List<ArticleModel>? _sieraArticles;

  Future<List<CategoryModel>> getCategories() async {
    if (_categories != null) return _categories!;
    
    final String response = await rootBundle.loadString('assets/data/islamhouse_categories.json');
    final List<dynamic> data = json.decode(response);
    _categories = data.map((json) => CategoryModel.fromJson(json)).toList();
    
    return _categories!;
  }

  Future<List<ArticleModel>> getProphetArticles() async {
    if (_prophetArticles != null) return _prophetArticles!;

    final String response = await rootBundle.loadString('assets/data/prophet_articles.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> articlesJson = data['data'];
    _prophetArticles = articlesJson.map((json) => ArticleModel.fromJson(json)).toList();

    return _prophetArticles!;
  }

  Future<List<ArticleModel>> getSieraArticles() async {
    if (_sieraArticles != null) return _sieraArticles!;

    final String response = await rootBundle.loadString('assets/data/siera_articles.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> articlesJson = data['data'];
    _sieraArticles = articlesJson.map((json) => ArticleModel.fromJson(json)).toList();

    return _sieraArticles!;
  }
}
