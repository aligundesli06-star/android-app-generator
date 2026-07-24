import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  Locale? _locale;
  int _currentIndex = 0;
  List<Recipe> _recipes = [];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _addNewRecipe() {
    setState(() {
      _recipes.add(Recipe(
        title: 'New Recipe',
        ingredients: ['Ingredient 1', 'Ingredient 2'],
        cookingTime: 30,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeRadar',
      locale: _locale,
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              recipes: _recipes,
              addNewRecipe: _addNewRecipe,
            ),
            ProgressScreen(),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              toggleDarkMode: _toggleDarkMode,
              selectLanguage: _selectLanguage,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewRecipe,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Recipe {
  final String title;
  final List<String> ingredients;
  final int cookingTime;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.cookingTime,
  });
}

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final VoidCallback addNewRecipe;

  const HomeScreen({
    Key? key,
    required this.recipes,
    required this.addNewRecipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'RecipeRadar',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.restaurant),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(recipes[index].title),
                        ),
                        Text('${recipes[index].cookingTime} minutes'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Progress',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Center(
                    child: Text('Progress Indicator'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;
  final VoidCallback selectLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.selectLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: Locale('en'),
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: Locale('es'),
                  ),
                ],
                onChanged: (value) {
                  // Implement language selection logic here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}