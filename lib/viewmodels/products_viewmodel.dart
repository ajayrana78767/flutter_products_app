import 'package:flutter/foundation.dart';
import 'package:flutter_products_app/core/network/api_endpoints.dart';
import 'package:flutter_products_app/core/network/app_client.dart';
import 'package:flutter_products_app/models/product_model.dart';

class ProductsViewmodel with ChangeNotifier {
  final AppClient _appClient = AppClient();
  List<Product> products = [];
  bool isLoading = false;
  String? error;

  // Fetch Products
  Future<void> fetchProducts() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final response = await _appClient.dio.get(ApiEndpoints.products);
      products = (response.data['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      notifyListeners();
    } catch (e) {
      error = e.toString();
      debugPrint(e.toString());
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
