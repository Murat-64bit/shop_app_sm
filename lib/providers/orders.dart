import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sm_shop_app/providers/cart.dart';
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

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> orderfetcAndSet() async {
    final url = Uri.parse(
        'https://my-demo-shop-app-default-rtdb.europe-west1.firebasedatabase.app/orders.json');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadOrders = [];
      if (extractedData == null) {
        return;
      } 
        extractedData.forEach((orderId, orderData) {
          loadOrders.add(OrderItem(
            id: orderId,
            amount: orderData["amount"],
            products: (orderData["products"] as List<dynamic>)
                .map((e) => CartItem(
                    id: e["id"],
                    title: e["title"],
                    quantity: e["quantity"],
                    price: e["price"]))
                .toList(),
            dateTime: DateTime.parse(orderData["dateTime"]),
          ));
        });
        _orders = loadOrders;
        notifyListeners();
      
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrders(List<CartItem> product, double total) async {
    final url = Uri.parse(
        'https://my-demo-shop-app-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'products': product
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
            'dateTime': DateTime.now().toIso8601String(),
          }));
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: product,
          dateTime: DateTime.now(),
        ),
      );
    } catch (error) {
      print(error);
      throw error;
    }

    notifyListeners();
  }
}
