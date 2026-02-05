import 'package:flutter/material.dart';

import 'category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryModel _model;

  CategoryViewModel(this._model);



  List<Category> categories = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSelected = false;

  List<Category> get category => categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSelected => _isSelected;


  Future<void> fetchCategory() async {
    try {

      _isSelected = false;
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      debugPrint('Fetching categories...');

      categories = await _model.getAllCategories();
      Category allCategory = Category(id: 0, name: "All", isSelected: true);
      categories.insert(0, allCategory);

      debugPrint('Fetched ${category.length} categories');
    } catch (e) {
      _errorMessage = 'Failed to load categories';
      debugPrint('Error fetching categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

