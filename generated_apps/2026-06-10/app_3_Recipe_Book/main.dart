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
  int _currentIndex = 0;
  bool isDarkMode = false;
  Locale _locale = const Locale('en');

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      locale: _locale,
      theme: isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons бар_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> _recipes = [
    Recipe(
      title: 'Recipe 1',
      description: 'Description 1',
      ingredients: ['Ingredient 1', 'Ingredient 2'],
    ),
    Recipe(
      title: 'Recipe 2',
      description: 'Description 2',
      ingredients: ['Ingredient 3', 'Ingredient 4'],
    ),
  ];

  void addRecipe() {
    setState(() {
      _recipes.add(
        Recipe(
          title: 'New Recipe',
          description: 'New Description',
          ingredients: ['New Ingredient'],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _recipes[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Icon(Icons.favorite_border),
                      ],
                    ),
                    Text(_recipes[index].description),
                    const SizedBox(height: 8.0),
                    Text(
                      'Ingredients: ${_recipes[index].ingredients.join(', ')}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addRecipe,
        tooltip: 'Add Recipe',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '75%',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              Icon(Icons.bar_chart),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.75,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  Locale _locale = const Locale('en');

  void toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Language',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              DropdownButton<Locale>(
                value: _locale,
                items: [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: const Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: const Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: const Locale('es'),
                  ),
                ],
                onChanged: (locale) {
                  changeLanguage(locale!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });
}