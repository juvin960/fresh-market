import 'dart:convert';
import '../../../services/api_client.dart';
import '../../../services/end_points.dart';

class Category{
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] ?? json['_id'] ?? '').toString();
    final name = (json['name'] ?? json['title'] ?? '').toString();
    return Category(id: id, name: name);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}


class CategoryModel {
  final ApiClient _client;

  CategoryModel(this._client);

  Future<List<Category>> getAllCategories() async {
    final response = await _client.get(Endpoints.getAllCategories);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final dynamic raw = decoded['data'] ?? decoded['items'] ?? [];
      final List<dynamic> rawList = raw is List ? raw : [];

      return rawList.map((e) {
        final Map<String, dynamic> item =
        e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map);
        return Category.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }
}
