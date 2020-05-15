import 'package:flutter/material.dart';

import './category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color; // for background

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctxt) {
    // Navigator.of(ctxt).push(MaterialPageRoute(
    //   builder: (_) {
    //     return CategoryMealsScreen(id, title);
    //   },
    // ));
    //Navigate to Category Meals Screen via routing
    Navigator.of(ctxt).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //adjusting transparency of color shades
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
