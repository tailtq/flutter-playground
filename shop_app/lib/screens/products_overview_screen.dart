import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  all,
  favorites,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, Cart cart, child) => Badge(
              child: child!,
              value: cart.itemCount.toString(),
              color: Theme.of(context).accentColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
            ],
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGrid(_showFavorites),
    );
  }
}
