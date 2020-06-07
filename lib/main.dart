import 'package:flutter/material.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen_bottom.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //filters are managed at main file as form here it can be communicated to filters screen as well as Category Meals Screen
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactose': false,
  };

  //available Meals that can be communicated to category-meals screen & other meals related screen
  List<Meal> _availableMeals = DUMMY_MEALS;

  //favourite meals is maintained over here because we want fav list maintained to communicate with
  List<Meal> _favoriteMeals = [];

  //Filters & Category Meals Screen are availabe over here in main file, so we need to manage filters changes over here
  void _saveFilters(Map<String, bool> newFilters) {
    setState(() {
      _filters = newFilters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }
  
  //This method will handle the check/uncheck of favorite meal
  void _toggleFavorite(String mealId){
    int existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    //Meal is already there in favorite list so remove it
    if(existingIndex >= 0){
      //Here this approach is not efficient as for toggling between Favorite Screen, Whole App is rebuilded often every time
      //which is not sign of a good performance
      //Here we are rebuilding everything for Favorite screen, which seems pretty un reasonable
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }// New meal to favorite list
  }
 
  //check if meal is included in favorite list or not
  bool _isFavoriteMeal(String mealId){
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.pinkAccent,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      //Widget that points as first screen in application
      //home: CategoriesScreen(),
      initialRoute: '/', //default is '/'
      routes: {
        //here ctxt is may be context of new screen going to be coming on screen
        '/': (ctxt) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctxt) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctxt) => MealDetailScreen(_toggleFavorite, _isFavoriteMeal),
        FiltersScreen.routeName: (ctxt) => FiltersScreen(_filters, _saveFilters),
      },
      // //Useful when no named route are found in routes table
      // onGenerateRoute: (settings){
      //   if(settings.name == '/meal-details')
      //     return MaterialPageRoute(builder: (ctxt) => CategoriesScreen());
      // },
      //Useful when no route configuration are found then at last this will be reached
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctxt) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals App'),
      ),
      body: Center(
        child: Text("Some Data"),
      ),
    );
  }
}
