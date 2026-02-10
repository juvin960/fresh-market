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
  Region? selectedRegion;
  Cart? selectedItem;
  double _total = 0.0;

  List<Cart> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Region> get regions => _regions;
  double get total => _total;



  Future<bool> addSelectedToCart( {
   required int productId,
    required int selectedUnitTypeId,
    required double quantity,
}) async {
    debugPrint(' selected item');
    // if (selectedItem == null) {
    //
    //   _errorMessage = 'No item selected';
    //   return false;
    // }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint('added to cart');
       await _model.addToCart(
        productId: productId,
        selectedUnitTypeId: selectedUnitTypeId,
        quantity: quantity,

      );
      return true;
    } catch (e) {
      _errorMessage = 'Failed to add item';
      debugPrint('Error adding to cart: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCartItems() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      debugPrint('Fetching cart items...');

      final Map<String, dynamic> response = await _model.getCartItems();
      _cartItems = response['cartItems'];
      _total = response['total'];


      debugPrint('Fetched ${_cartItems.length} items, total: $_total');
    } catch (e) {
      _errorMessage = 'Failed to load cart items';
      debugPrint('Error fetching cart items: $e');
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
      if (regions.isNotEmpty) {
        selectedRegion = regions.first;
      }

      debugPrint('Fetched ${_regions.length} regions');
    } catch (e) {
      _errorMessage = 'Failed to load regions ';
      debugPrint('Error fetching regions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void setSelectedRegion(Region? region) {
    selectedRegion = region;
    notifyListeners();
  }

  void incrementQuantity(int cartId) {
    final index = _cartItems.indexWhere((e) => e.id == cartId);
    if (index == -1) return;

    final item = _cartItems[index];
    _cartItems[index] = Cart(
      id: item.id,
      productId: item.productId,
      name: item.name,
      price: item.price,
      quantity: item.quantity + 1,
      unitTypeId: item.unitTypeId,
      unitTypeName: item.unitTypeName,
    );

    notifyListeners();
  }

  void decrementQuantity(int cartId) {
    final index = _cartItems.indexWhere((e) => e.id == cartId);
    if (index == -1) return;

    final item = _cartItems[index];
    if (item.quantity <= 1) return;

    _cartItems[index] = Cart(
      id: item.id,
      productId: item.productId,
      name: item.name,
      price: item.price,
      quantity: item.quantity - 1,
      unitTypeId: item.unitTypeId,
      unitTypeName: item.unitTypeName,
    );

    notifyListeners();
  }


}