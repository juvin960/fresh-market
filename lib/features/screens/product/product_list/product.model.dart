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
 final bool isFreshProduce;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.unit,
    this.category,
    this.imageUrl,
    this.description,
    this.isFreshProduce = false,
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
      isFreshProduce: json['is_fresh_produce'] ?? false,
    );
  }
}

class PageInfo {
  final int currentPage;
  final int lastPage;

  PageInfo({
    required this.currentPage,
    required this.lastPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      currentPage: json["current_page"] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }
}

class ProductModel {
  final ApiClient _client;

  ProductModel(this._client);

  Future<Map<String, dynamic>> getAllProducts({int? categoryId, int page=1}) async {
    Map<String, String> queryParams = {
      "page": page.toString(),
      "per_page": "4",
    };

    if (categoryId != null) {
      queryParams['category_id'] = categoryId.toString();
    }
    final Map<String, dynamic> response = await _client.get(
      Endpoints.getAllProducts,
      queryParams: queryParams,
    );

    final List<dynamic> rawList =
        (response['data']?['data'] ?? []) as List<dynamic>;

    List<Product> products = rawList.map((e) {
      return Product.fromJson(Map<String, dynamic>.from(e));
    }).toList();
    // Map<String, dynamic> pageInfoMap = {};

    PageInfo pageInfo = PageInfo(
        currentPage: response['data']?['current_page'] ?? 1,
        lastPage: response['data']?['last_page'] ?? 1
    );


    return {
      "products": products,
      "pageInfo": pageInfo,
    };

  }
}
