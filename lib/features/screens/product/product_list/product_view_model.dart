import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/screens/product/product_list/product.model.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductModel _model;

  ProductViewModel(this._model);

  List<Product> _allProducts = [];
  List<Product> products = [];
  List<String> categories = [];
  bool isLoading = false;
  String? errorMessage;


  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _model.getAllProducts();

      _allProducts = data;
      products = List.from(_allProducts);


      categories = _allProducts.map((e) => e.category ?? "Unknown").toSet().toList();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void filterProducts(String query, [String? selectedCategory]) {
    products = _allProducts.where((p) {
      final matchesQuery = p.name.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = selectedCategory == null || selectedCategory == "All"
          ? true
          : p.category == selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
    notifyListeners();
  }


  void filterByCategory(String category) {
    products = _allProducts
        .where((p) => category == "All" ? true : p.category == category)
        .toList();
    notifyListeners();
  }
}

