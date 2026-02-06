import 'package:flutter/cupertino.dart';
import 'package:fresh_market_app/features/screens/cart/cart_model.dart';
import 'package:fresh_market_app/features/screens/region_model.dart';

class CartViewModel extends ChangeNotifier {
  final CartModel _model;


  CartViewModel(this._model);
  List<Cart> _cartItems = [];
  List<Region> _regions = [];
  bool _isLoading = false;
  String? _errorMessage;



  List<Cart> get items => _cartItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Region> get regions => _regions;



  Future<void> addToCart() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      debugPrint('Adding item to cart...');

      _cartItems = await _model.addToCart();

      debugPrint('Added ${_cartItems.length} items to cart');
    } catch (e) {
      _errorMessage = 'Failed to add item to cart';
      debugPrint('Error adding item to cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllRegions() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      debugPrint('Fetching regions...');

      _regions = await _model.getAllRegions();

      debugPrint('Fetched ${_regions.length} cart items');
    } catch (e) {
      _errorMessage = 'Failed to load regions ';
      debugPrint('Error fetching regions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}