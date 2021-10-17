import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';

// ignore: must_be_immutable
class BottomTabsScreen extends StatefulWidget {
  late List<Meal> _favouriteMeals = [];

  BottomTabsScreen(this._favouriteMeals);

  @override
  _BottomTabsScreenState createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  late List<Map<String, dynamic>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget._favouriteMeals), 'title': 'Your favorite'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget? _getPage(String pageType) {
    return {
      'categories': CategoriesScreen(),
      'favorites': FavoritesScreen(widget._favouriteMeals),
    }[pageType];
  }

  @override
  Widget build(BuildContext context) {
    print('oKE');
    print(widget._favouriteMeals);
    Map<String, dynamic> page = _pages[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(page['title']),
      ),
      drawer: MainDrawer(),
      body: page['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
