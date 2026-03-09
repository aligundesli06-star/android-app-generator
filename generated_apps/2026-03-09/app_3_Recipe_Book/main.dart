import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _recipes = [
    Recipe('Spaghetti', 'Italian', '30 minutes'),
    Recipe('Chicken Fajitas', 'Mexican', '20 minutes'),
    Recipe('Vegetable Soup', 'American', '40 minutes'),
  ];

  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProgressPage()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(recipes: _recipes),
          const ProgressPage(),
          SettingsPage(
            isDarkMode: _isDarkMode,
            language: _language,
            onToggleDarkMode: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            onLanguageChange: (value) {
              setState(() {
                _language = value;
              });
            },
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewRecipe();
        },
        tooltip: 'Add New Recipe',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNewRecipe() {
    setState(() {
      _recipes.add(Recipe('New Recipe', 'New Cuisine', 'New Time'));
    });
  }
}

class Recipe {
  final String name;
  final String cuisine;
  final String cookingTime;

  Recipe(this.name, this.cuisine, this.cookingTime);
}

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const HomeScreen({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: recipes.map((recipe) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    recipe.cuisine,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    recipe.cookingTime,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      Icon(Icons.timer),
                      SizedBox(width: 8),
                      Text('Cooking Time'),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Progress'),
              const Spacer(),
              Text(
                '75%',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.75,
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onToggleDarkMode;
  final Function(String) onLanguageChange;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onToggleDarkMode,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: onToggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: language,
                onChanged: onLanguageChange,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}