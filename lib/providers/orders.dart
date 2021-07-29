import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shoppinggu/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        "https://shoppinggu-ad120-default-rtdb.firebaseio.com/orders.json");

    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final Map<String, dynamic>? extractedData = json.decode(response.body);

    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderId, order) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: order['amount'],
        products: (order['products'] as List<dynamic>)
            .map(
              (item) => CartItem(
                id: item['id'],
                title: item['title'],
                quantity: item['quantity'],
                price: item['price'],
              ),
            )
            .toList(),
        dateTime: DateTime.parse(order['dateTime']),
      ));
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now().toIso8601String();
    final url = Uri.parse(
        "https://shoppinggu-ad120-default-rtdb.firebaseio.com/orders.json");
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp,
          'products': cartProducts
              .map(
                (product) => {
                  'id': product.id,
                  'title': product.title,
                  'quantity': product.quantity,
                  'price': product.price,
                },
              )
              .toList(),
        }));

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
