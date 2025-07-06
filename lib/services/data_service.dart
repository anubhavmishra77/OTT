import 'dart:convert';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart';
import '../models/category.dart';
import '../models/video.dart';

class DataService {
  static Future<List<Category>> loadCategories() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/mock_data.json');
      final Map<String, dynamic> data = json.decode(response);

      return (data['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList();
    } catch (e) {
      debugPrint('Error loading categories: $e');
      return [];
    }
  }

  static List<Video> getAllVideos(List<Category> categories) {
    List<Video> allVideos = [];
    for (var category in categories) {
      allVideos.addAll(category.videos);
    }
    return allVideos;
  }
}
