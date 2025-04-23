// lib/Services/book_api_service.dart
import 'dart:convert';
import 'package:books_collection/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class BookApiService {
  Future<List<Map<String, dynamic>>> fetchBooks({
    required int offset,
    int limit = 10,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/subjects/novel.json?offset=$offset&limit=$limit');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final works = data['works'] as List<dynamic>;
        return works
            .whereType<Map<String, dynamic>>()
            .toList();
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }
}
