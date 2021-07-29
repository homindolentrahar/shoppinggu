import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shoppinggu/models/http_exception.dart';
import 'package:shoppinggu/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  List<Product> get items => [..._items];

  Product findProductById(String productId) {
    return _items.firstWhere((prod) => prod.id == productId);
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse(
        "https://shoppinggu-ad120-default-rtdb.firebaseio.com/products.json");

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, product) {
        loadedProducts.add(Product(
            id: prodId,
            title: product['title'],
            description: product['description'],
            price: product['price'],
            imageUrl: product['imageUrl'],
            isFavorite: product['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://shoppinggu-ad120-default-rtdb.firebaseio.com/products.json");

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      final id = json.decode(response.body)['name'];
      final newProduct = Product(
        id: id,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String productId, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == productId);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          "https://shoppinggu-ad120-default-rtdb.firebaseio.com/products/$productId.json");
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price
          }));

      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
    final url = Uri.parse(
        "https://shoppinggu-ad120-default-rtdb.firebaseio.com/products/$productId.json");
    final existingProductIndex =
        _items.indexWhere((prod) => prod.id == productId);
    Product? existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Could not delete product");
    }
    existingProduct = null;
  }
}
