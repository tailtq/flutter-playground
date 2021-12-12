import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class MainDrawer extends StatelessWidget {
  ListTile getTab(IconData icon, String title, void Function() tabHandler) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: true,
          ),
          getTab(
            Icons.shop,
            'Shop',
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          getTab(
            Icons.payment,
            'Orders',
            () => Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
          getTab(
            Icons.edit,
            'Manage Products',
            () => Navigator.of(context).pushNamed(UserProductsScreen.routeName),
          ),
          getTab(
            Icons.shopping_cart,
            'Cart',
            () => Navigator.of(context).pushNamed(CartScreen.routeName),
          ),
        ],
      ),
    );
  }
}
