import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String,bool> currentFilters;
  final Function saveFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isVegetarian = false;
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isLactoseFree = false;

  @override
  void initState() { 
    super.initState();
    _isVegetarian = widget.currentFilters['vegetarian'];
    _isGlutenFree = widget.currentFilters['gluten'];
    _isVegan = widget.currentFilters['vegan'];
    _isLactoseFree = widget.currentFilters['lactose'];
  }

  //Use to build Switch ListTile under Listview
  Widget _buildSwitchListTile({
    String title,
    String description,
    bool currValue,
    Function updateValue,
  }) {
    return SwitchListTile(
      title: Text('Gluten-free'),
      subtitle: Text('Only include gluten-free meals.'),
      value: _isGlutenFree,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => widget.saveFilters(<String, bool>{
              'gluten': _isGlutenFree,
              'vegan': _isVegan,
              'vegetarian': _isVegetarian,
              'lactose': _isLactoseFree,
            }),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your Meal Selection - ',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  title: 'Gluten-free',
                  description: 'Only include gluten-free meals.',
                  currValue: _isGlutenFree,
                  updateValue: (value) {
                    setState(() {
                      _isGlutenFree = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vegetarian',
                  description: 'Only include vegetarian meals.',
                  currValue: _isVegetarian,
                  updateValue: (value) {
                    setState(() {
                      _isVegetarian = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vegan',
                  description: 'Only include vegan meals.',
                  currValue: _isVegan,
                  updateValue: (value) {
                    setState(() {
                      _isVegan = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: 'Lactos-Free',
                  description: 'Only include lactose-free meals.',
                  currValue: _isLactoseFree,
                  updateValue: (value) {
                    setState(() {
                      _isLactoseFree = value;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
