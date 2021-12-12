import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;

    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(String productId, String title, int quantity, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (cartItem) => CartItem(
          id: cartItem.id,
          productId: cartItem.productId,
          title: cartItem.title,
          price: cartItem.price,
          quantity: cartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          productId: productId,
          title: title,
          quantity: quantity,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (cartItem) => CartItem(
          id: cartItem.id,
          productId: cartItem.productId,
          title: cartItem.title,
          price: cartItem.price,
          quantity: cartItem.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
