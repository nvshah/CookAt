import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  //Use to ensure that data are initialised for only one time for State 
  var _loadedInitData = false;
  
  //Remove Meal that is trashed from meal details page
  void _removeMeal(String mealId) {
    //here setState is overwritten as didChangeDependencies() runs again
    //So we basically loads all meals again
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void initState() {
    //...context stuff will not work here so we shift that to didChangeDependencies()
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //Data in below block is loaded only for 1st time & that is ensured so that we do not face any problem of Syncing & Updation
    //problem of setState() being overriden by the below data is resolved
    if (!_loadedInitData) {
      //When page or state gets loaded then we want to load all meals based on categoryID
      //fetching data passed on route
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      //getting all the meals particularly for selected category
      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      //So next time when backward navigation happen we do not face problem of overriden
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //Screen for List of Meals pertaining to particular category
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctxt, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            removeMeal: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
