import '../../../services/api_client.dart';
import '../../../services/end_points.dart';
class Product {
  final String id;
  final String name;
  final double price;
  final String? unit;
  final String? category;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.unit,
    this.category,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      unit: json['unit'] ?? 'per unit',
      category: json['category'] ?? 'Fresh',
      imageUrl: json['image_url'],
    );
  }
}

class ProductModel {
  final ApiClient _client;

  ProductModel(this._client);

  Future<List<Product>> getAllProducts({String? categoryUuid}) async {
    final Map<String, dynamic> response = await _client.get(
      Endpoints.getAllProducts,
      queryParams: categoryUuid != null ? {'category_uuid': categoryUuid} : null,
    );


    final List<dynamic> rawList = (response['data']?['data'] ?? []) as List<dynamic>;

    return rawList.map((e) {
      return Product.fromJson(
        Map<String, dynamic>.from(e),
      );
    }).toList();
  }
}

