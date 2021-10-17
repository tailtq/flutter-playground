import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/filter_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/not_found_screen.dart';
import './screens/bottom_tabs_screen.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'glutenFree': false,
    'vegetarian': false,
    'vegan': false,
    'lactoseFree': false,
  };
  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  @override
  void initState() {
    super.initState();
  }

  void _saveFilters(Map<String, bool> filters) {
    setState(() {
      this.filters = filters;

      _meals = DUMMY_MEALS.where((meal) {
        if (filters['glutenFree']! && !meal.isGlutenFree) {
          return false;
        }
        if (filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (filters['lactoseFree']! && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    setState(() {
      print('SET STATE');
      int index = _favoriteMeals.indexWhere((element) => element.id == mealId);

      if (index >= 0) {
        _favoriteMeals.removeAt(index);
      } else {
        _favoriteMeals.insert(0, _meals.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  bool _isFavoriteMeal(Meal meal) {
    return _favoriteMeals.any((element) => element.id == meal.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext ctx) => BottomTabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (BuildContext ctx) =>
            CategoryMealsScreen(_meals),
        MealDetailScreen.routeName: (BuildContext ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavoriteMeal),
        FilterScreen.routeName: (BuildContext ctx) =>
            FilterScreen(filters, _saveFilters),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
      },
    );
  }
}
