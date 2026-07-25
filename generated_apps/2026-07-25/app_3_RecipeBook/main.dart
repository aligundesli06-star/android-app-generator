import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: MyHomePage(
        currentIndex: _currentIndex,
        isDarkMode: _isDarkMode,
        language: _language,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        toggleDarkMode: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
        changeLanguage: (language) {
          setState(() {
            _language = language;
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
  final Function(int) onTap;
  final Function toggleDarkMode;
  final Function(String) changeLanguage;

  MyHomePage({
    required this.currentIndex,
    required this.isDarkMode,
    required this.language,
    required this.onTap,
    required this.toggleDarkMode,
    required this.changeLanguage,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _recipes = [
    'Recipe 1',
    'Recipe 2',
    'Recipe 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            recipes: _recipes,
          ),
          ProgressScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
          ),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            toggleDarkMode: widget.toggleDarkMode,
            changeLanguage: widget.changeLanguage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onTap(index);
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
        onPressed: () {
          setState(() {
            _recipes.add('New Recipe ${_recipes.length}');
          });
        },
        tooltip: 'Add Recipe',
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final List<String> recipes;

  HomeScreen({
    required this.isDarkMode,
    required this.language,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: recipes
            .map(
              (recipe) => Card(
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
                      Text(
                        recipe,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;

  ProgressScreen({
    required this.isDarkMode,
    required this.language,
  });

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
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.circle),
              SizedBox(width: 16),
              Text('Indicator 1'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle),
              SizedBox(width: 16),
              Text('Indicator 2'),
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
  final Function toggleDarkMode;
  final Function(String) changeLanguage;

  SettingsScreen({
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Dark Mode'),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language'),
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
                  changeLanguage(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}