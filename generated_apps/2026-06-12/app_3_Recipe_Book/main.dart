import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(
        currentIndex: _currentIndex,
        isDarkMode: _isDarkMode,
        language: _language,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onThemeChange: (isDark) {
          setState(() {
            _isDarkMode = isDark;
          });
        },
        onLanguageChange: (lang) {
          setState(() {
            _language = lang;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final bool isDarkMode;
  final String language;
  final Function(int) onTabChange;
  final Function(bool) onThemeChange;
  final Function(String) onLanguageChange;

  const MyHomePage({
    super.key,
    required this.currentIndex,
    required this.isDarkMode,
    required this.language,
    required this.onTabChange,
    required this.onThemeChange,
    required this.onLanguageChange,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Recipe> _recipes = [];

  void _addRecipe() {
    setState(() {
      _recipes.add(Recipe(
        title: 'New Recipe',
        description: 'New Recipe Description',
        ingredients: ['Ingredient 1', 'Ingredient 2'],
        steps: ['Step 1', 'Step 2'],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            recipes: _recipes,
            onAddRecipe: _addRecipe,
          ),
          ProgressScreen(),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            onThemeChange: widget.onThemeChange,
            onLanguageChange: widget.onLanguageChange,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onTabChange(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        tooltip: 'Add Recipe',
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final Function onAddRecipe;

  const HomeScreen({
    super.key,
    required this.recipes,
    required this.onAddRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.restaurant),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipes[index].title,
                          style: Theme.of(context).titleLarge,
                        ),
                        Text(
                          recipes[index].description,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
          Row(
            children: [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).titleLarge,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  Text('Calories'),
                  Text('1000'),
                ],
              ),
              SizedBox(width: 16),
              Column(
                children: [
                  Text('Protein'),
                  Text('50g'),
                ],
              ),
              SizedBox(width: 16),
              Column(
                children: [
                  Text('Carbs'),
                  Text('200g'),
                ],
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
  final String language;
  final Function(bool) onThemeChange;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.onThemeChange,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 16),
              Text(
                'Settings',
                style: Theme.of(context).titleLarge,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Dark Mode'),
              SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onThemeChange(value);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Language'),
              SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: [
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
                onChanged: (value) {
                  onLanguageChange(value as String);
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
  final List<String> steps;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
  });
}