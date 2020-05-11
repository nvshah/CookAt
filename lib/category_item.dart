import 'package:flutter/material.dart';

import './categories_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color; // for background

  CategoryItem(this.title, this.color);

  void selectCategory(BuildContext ctxt) {
    Navigator.of(ctxt).push(MaterialPageRoute(
      builder: (_) {
        return CategoriesScreen();
      },
    ));
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
