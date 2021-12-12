import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final List<CartItem> products;
  final double amount;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.products,
    required this.amount,
    required this.dateTime,
  });
}

class Orders extends ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        products: cartProducts,
        amount: total,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
