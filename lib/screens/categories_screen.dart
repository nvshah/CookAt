import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thy Meal'),
      ),
      body: GridView(
        padding: EdgeInsets.all(15),
        children: DUMMY_CATEGORIES
            .map((catData) => CategoryItem(catData.id, catData.title, catData.color))
            .toList(),
        //Sliver means scrollable | according to width available of device
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //How many max width in terms of pixel
          maxCrossAxisExtent: 200,
          //Ratio of height to width for each children delegate/contestant
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
