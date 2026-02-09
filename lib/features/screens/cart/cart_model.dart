import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fresh_market_app/features/services/api_client.dart';

import '../../services/end_points.dart';

class Cart {
  final int id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final int unitTypeId;
  final String unitTypeName;





  Cart(  {
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.unitTypeId,
    required this.unitTypeName,

  });

  double get totalPrice => price * quantity;


  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      productId: json['id'],
      name: json['product']['name'],
      price: double.parse(json['unit_price'].toString()),
      quantity: int.parse(json['selected_quantity']),
      unitTypeId: json['selected_unit_type_id'],
      unitTypeName: json['unit_type']['name'],
    );
  }
}

class CartModel {
  final ApiClient _client;

  CartModel(this._client);

  Future<Map <String, dynamic>> addToCart({
    required int productId,
      required int selectedUnitTypeId,
      required double quantity,
}) async {
    var body = {
      'product_id': productId,
      'selected_unit_type_id': selectedUnitTypeId,
      'selected_quantity': quantity,
    };
    debugPrint('Product id is $productId');


    var response =
    await _client.post(Endpoints.addToCart,
        data: body

    );
    debugPrint('response is $response');


    // Map<String, dynamic> decoded = jsonDecode(response);

    if(response['errorOccurred'] == true) {
      throw Exception(response['message'] ?? 'Failed to add item to cart');
    }else {
      return response;
    }

  }

  Future<Map<String, dynamic>> getCartItems() async {

    final Map<String, dynamic> response =
    await _client.get(Endpoints.getCartItems);

    final dynamic raw = response['data'] ?? {};
    var rawList = raw['cart']['items'];
    double total = raw['total'];


    List<Cart> cartItems = rawList.map((e) {
      return Cart.fromJson(Map<String, dynamic>.from(e));
    }).toList();

    return  {
      'cartItems': cartItems,
      'total' : total,
    };


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

