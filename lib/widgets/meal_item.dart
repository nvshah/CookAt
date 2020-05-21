import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeMeal;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.removeMeal,
  });

  void selectMeal(BuildContext ctxt) {
    //Navigate to Meal Details Screen on tapping any image of meal
    //then method will be executed when MealDetailScreen is popped out
    //then() method will not called when pushing is done, but when you are done with the page that is pushed to i,e when that page is popped from stack
    Navigator.of(ctxt)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((data) {
          //if we normally select back, in that case also pop() is called but at that time no data will be passed & thus null
          //print(data)
          if(data){
            removeMeal(data);
          }
        });
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            //IMAGE & TITLE
            //As we want to show text on image so that we are using stack
            Stack(
              children: <Widget>[
                //MEAL IMAGE
                //It's used to clipping setup for image so that it fit properly to parent's rounded border on upper side
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    //Image will not take the entire height of a card
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  //Image that needed to be clipped | Image is taken from internet
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    //resize the image so that it's fit into the box of dimension 250 * infinity
                    fit: BoxFit.cover,
                  ),
                ),
                //MEAL TITLE
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    // Here we used Container to wrap becuase When Text Overflow it was not getting clipped as it was getting width of stack i.e by default infinity for now
                    // so we need to wrap that text inside container of specific width inorder to work those softWrap & overflow property effectivelu
                    width: 300,
                    //transparency black
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      //if text is too long to fit then it will be wrapped
                      softWrap: true,
                      //even if after Wrapping the text it overflow, then it will be cropped or clipped to fit the box|Container
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                //Here We can also Wrap each nested row eith Expanded for Equally sized children of this Row
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexity.toString().split('.').last),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text(affordability.toString().split('.').last),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
