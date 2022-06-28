import 'package:flutter/material.dart';
import 'package:mealee/dummy_data.dart';
import 'package:mealee/screens/filters_screen.dart';
import 'package:mealee/screens/meal_detail_screen.dart';
import 'models/meal.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(Mealee());
}

class Mealee extends StatefulWidget {
  const Mealee({Key? key}) : super(key: key);

  @override
  State<Mealee> createState() => _MealeeState();
}

class _MealeeState extends State<Mealee> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = kDummyMeals;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = kDummyMeals.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(kDummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          //the primarySwatch now placed into this code
          primary: Colors.pink,
          //the new accent color code
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavorite: _toggleFavorite, isMealFavorite: isMealFavorite),
        FiltersScreen.routeName: ((context) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: _setFilters,
            )),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: ((context) => const CategoriesScreen()));
      },
    );
  }
}
