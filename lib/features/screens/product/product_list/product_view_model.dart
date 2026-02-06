import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/screens/product/product_list/product.model.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductModel _model;

  ProductViewModel(this._model);

  List<Product> _allProducts = [];
  List<Product> products = [];
  int _currentPage = 1;
  int get currentPage => _currentPage;
  int _lastPage = 1;
  int get lastPage => _lastPage;


  List<String> categories = [];
  bool isLoading = false;
  String? errorMessage;



  Future<void> fetchProducts({int? categoryId, int page = 1}) async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _model.getAllProducts(categoryId: categoryId, page: page);

      _allProducts = data["products"] as List<Product>;
      products.addAll(_allProducts);
      PageInfo pageInfo = data["pageInfo"] as PageInfo;
      _currentPage = pageInfo.currentPage;
      _lastPage =  pageInfo.lastPage;

      isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      debugPrint("error is ${e.toString()}");
      debugPrint(stackTrace.toString());
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

  bool isProductListEmpty() {
    return products.isEmpty;
  }

  void clearProducts() {
    _allProducts.clear();
    products.clear();
    _currentPage = 1;
    _lastPage = 1;
    notifyListeners();
  }
}

