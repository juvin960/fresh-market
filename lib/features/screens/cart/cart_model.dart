import 'package:fresh_market_app/features/services/api_client.dart';

import '../../services/end_points.dart';

class Cart {
  final String id;
  final String name;
  final double price;
  final int quantity;


  Cart({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;


  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: double.parse(json['price']?.toString() ?? "0"),
      quantity: int.parse(json['quantity']?.toString() ?? "0"),
    );
  }
}

class CartModel {
  final ApiClient _client;

  CartModel(this._client);

  Future<List<Cart>> addToCart() async {
    final Map<String, dynamic> response =
    await _client.get(Endpoints.addToCart);


    final dynamic raw = response['data'] ?? [];
    final List<dynamic> rawList = raw is List ? raw : [];

    return rawList.map((e) {
      return Cart(
        id: e['id'].toString(),
        name: e['name'] ?? '',
        price: double.parse(e['price']?.toString() ?? "0"),
        quantity: int.parse(e['quantity']?.toString() ?? "0"),
      );
    }).toList();
  }

  Future<List<Region>> getAllRegions() async {
    final Map<String, dynamic> response =
    await _client.get(Endpoints.getAllRegions);

    final dynamic raw = response['data'] ?? [];
    final List<dynamic> rawList = raw is List ? raw : [];

    return rawList.map((e) {
      return Region(
        name: e['name'] ?? '',
      );
    }).toList();
  }
}



class Region {
  final String name;


  Region({
    required this.name,
  });
  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(

      name: json['name'] ?? '',

    );
  }

}

