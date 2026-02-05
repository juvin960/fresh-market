import 'dart:convert';
import '../../../services/api_client.dart';
import '../../../services/end_points.dart';

class Category{
  final int id;
  final String name;
  bool isSelected;


  Category({
    required this.id,
    required this.name,
    this.isSelected = false
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final id = json['_id'] ?? 0;
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
    final Map<String, dynamic> response =
    await _client.get(Endpoints.getAllCategories);

    final dynamic raw = response['data'] ?? [];

    final List<dynamic> rawList = raw is List ? raw : [];

    return rawList.map((e) {
      return Category.fromJson(
        Map<String, dynamic>.from(e),
      );
    }).toList();
  }
}

