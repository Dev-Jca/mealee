import 'package:flutter/material.dart';
import 'package:mealee/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter_screen';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FiltersScreen(
      {required this.currentFilters, required this.saveFilters, Key? key})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = (widget.currentFilters['gluten']) as bool;
    _vegetarian = (widget.currentFilters['vegetarian']) as bool;
    _vegan = (widget.currentFilters['vegan']) as bool;
    _lactoseFree = (widget.currentFilters['lactose']) as bool;
    super.initState();
  }

  Widget buildSwitchListTile(
      {required Function(bool)? updateValue,
      required bool currentVal,
      required String text1,
      required String text2}) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(text1),
      value: (currentVal),
      onChanged: updateValue,
      subtitle: Text(text2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection here',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  updateValue: (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                  currentVal: _glutenFree,
                  text1: 'Gluten-Free',
                  text2: 'Only include gluten-free meals',
                ),
                buildSwitchListTile(
                  updateValue: (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                  currentVal: _vegetarian,
                  text1: 'Vegetarian',
                  text2: 'Only include vegetarian meals',
                ),
                buildSwitchListTile(
                  updateValue: (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                  currentVal: _vegan,
                  text1: 'Vegetarian',
                  text2: 'Only include vegetarian meals',
                ),
                buildSwitchListTile(
                  updateValue: (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                  currentVal: _lactoseFree,
                  text1: 'Lactose-Free',
                  text2: 'Only include lactose-free meals',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
