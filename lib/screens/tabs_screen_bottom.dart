import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorite_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;

  TabsScreen(this.favoriteMeal);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //widget obj is not avail at moment so we are not initializing the _pages, as _pages requires widget.favoriteMeals in TabScreen as a argument
  //List of pages corresponding to the tabs
  List<Map<String, Object>> _pages;

  //hold the current page index <=>
  int _selectedPageIndex = 0;
  
  //We have shifted the _pages initialization to initState() because widget object was not available to the 
  //State class property during initialization
  //but widget is available in build() & initState() method of State so we can assign the _page value over there
  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoriteScreen(widget.favoriteMeal), 'title': 'Thy Favorites'},
    ];
    super.initState();
  }

  //this will use to change the state & render appropriate screen when user select any tab from tap bar
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        //type: BottomNavigationBarType.shifting,
        //tells which tab is selected
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            //if type is defined for btmnavbar then you need to give manually background color for each item
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
