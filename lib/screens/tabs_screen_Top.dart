import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    // tab bar will appear at top of the screen, below the appbar
    return DefaultTabController(
      length: 2,
      //this means that Favorites screen will appear by default
      //initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          //tabs
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        //correspondent TabBar screen rendering content
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            FavoriteScreen(),
          ],
        ),
      ),
    );
  }
}
