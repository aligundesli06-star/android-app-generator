import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RecipeBook();
  }
}

class RecipeBook extends StatefulWidget {
  const RecipeBook({Key? key}) : super(key: key);

  @override
  State<RecipeBook> createState() => _RecipeBookState();
}

class _RecipeBookState extends State<RecipeBook> {
  int _currentIndex = 0;
  bool _darkMode = false;
  String _language = 'English';

  final List<Map<String, dynamic>> _recipes = [
    {'name': 'Recipe 1', 'description': 'Description 1'},
    {'name': 'Recipe 2', 'description': 'Description 2'},
    {'name': 'Recipe 3', 'description': 'Description 3'},
  ];

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      theme: _darkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_recipes),
            ProgressScreen(),
            SettingsScreen(_toggleDarkMode, _changeLanguage, _language),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
            _recipes.add({'name': 'New Recipe', 'description': 'New Description'});
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _recipes;

  const HomeScreen(this._recipes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.food_bank, size: 32),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _recipes[index]['name'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(_recipes[index]['description']),
                    ],
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(Icons.circle, size: 32, color: Colors.red),
                  Text('To-Do'),
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.circle, size: 32, color: Colors.yellow),
                  Text('In Progress'),
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.circle, size: 32, color: Colors.green),
                  Text('Done'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('25%'),
              Text('50%'),
              Text('100%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function _toggleDarkMode;
  final Function _changeLanguage;
  final String _language;

  const SettingsScreen(this._toggleDarkMode, this._changeLanguage, this._language, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: _language == 'English',
                onChanged: (value) {
                  _toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  _changeLanguage(value.toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}