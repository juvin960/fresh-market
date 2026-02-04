import '../../../services/api_client.dart';
import '../../../services/end_points.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String? unit;
  final String? category;
  final String? imageUrl;
  final String? description;
 // final bool isFreshProduce;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.unit,
    this.category,
    this.imageUrl,
    this.description,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: double.parse(json['base_price'] ?? "0"),
      unit: json['unit_type'] ?? 'per unit',
      category: json['category']["name"] ?? '',
      imageUrl: json['image_url'],
      description: json['description'] ?? "",
      //isFreshProduce: json['is_fresh_produce'] ?? false,
    );
  }
}

class ProductModel {
  final ApiClient _client;

  ProductModel(this._client);

  Future<List<Product>> getAllProducts({String? categoryId}) async {
    final Map<String, dynamic> response = await _client.get(
      Endpoints.getAllProducts,
      queryParams: categoryId != null ? {'category_id': categoryId} : null,
    );

    final List<dynamic> rawList =
        (response['data']?['data'] ?? []) as List<dynamic>;

    return rawList.map((e) {
      return Product.fromJson(Map<String, dynamic>.from(e));
    }).toList();
  }
}
