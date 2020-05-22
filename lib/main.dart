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

  //available Meals that can be coomunicated to category-meals screen
  List<Meal> _availableMeals = DUMMY_MEALS;

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
        '/': (ctxt) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctxt) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctxt) => MealDetailScreen(),
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
