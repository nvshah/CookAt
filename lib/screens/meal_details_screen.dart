import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-details';

  final Function toggleFavorite;
  final Function isFavoriteMeal;

  MealDetailScreen(this.toggleFavorite, this.isFavoriteMeal);

  //common title used in screen
  Widget mealDetailsScreenTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  //Common container
  Widget mealDetailsScreenContainer({Widget childWidget}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      //fixed height becuase we are using ListView(Scrollable) as a child
      height: 150,
      width: 300,
      child: childWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    //as only 1 arg is passed in route so directly accepting as a string
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    //List of ingredients
    final ingredeintListView = ListView.builder(
      itemCount: selectedMeal.ingredients.length,
      itemBuilder: (ctxt, index) => Card(
        //Card bg color
        color: Theme.of(context).accentColor,
        //Card text
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            selectedMeal.ingredients[index],
            style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),
          ),
        ),
      ),
    );

    //List of steps
    final stepsListView = ListView.builder(
      itemCount: selectedMeal.steps.length,
      itemBuilder: (ctxt, index) => Column(
        children: <Widget>[
          ListTile(
            //step number
            leading: CircleAvatar(child: Text('# ${index + 1}')),
            //step message
            title: Text(selectedMeal.steps[index]),
          ),
          //Divider between two steps as a gap seperator
          Divider(),
        ],
      ),
    );

    //SCRREN
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //IMAGE
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            //INGREDIENTS TITLE
            mealDetailsScreenTitle(context, 'Ingredients'),
            //INGREDIENTS BODY
            mealDetailsScreenContainer(childWidget: ingredeintListView),
            //STEPS TITLE
            mealDetailsScreenTitle(context, 'Steps'),
            //STEPS BODY
            mealDetailsScreenContainer(childWidget: stepsListView),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          //Icons.delete,
          isFavoriteMeal(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
        // onPressed: (){
        //   //Go back & remove mealId from List for now from meals details screen
        //   Navigator.of(context).pop(mealId);
        // },
      ),
    );
  }
}
