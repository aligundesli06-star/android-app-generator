import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RecipeApp();
  }
}

class RecipeApp extends StatefulWidget {
  const RecipeApp({Key? key}) : super(key: key);

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
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
      title: 'Recipe Book',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(_toggleDarkMode, _changeLanguage, _language),
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
            // Add new item
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.food_bank),
                      SizedBox(width: 16),
                      Text(
                        'Recipe 1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Description of recipe 1',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.cake),
                      SizedBox(width: 16),
                      Text(
                        'Recipe 2',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Description of recipe 2',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
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
          Row(
            children: [
              Column(
                children: const [
                  Text('Progress', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('75%', style: TextStyle(fontSize: 24)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.bar_chart, size: 48),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: const [
                  Text('Steps', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('5/10', style: TextStyle(fontSize: 24)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.step, size: 48),
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
              const Text('Dark mode', style: TextStyle(fontSize: 18)),
              const Spacer(),
              Switch(
                value: _language == 'Turkish' || _language == 'Spanish',
                onChanged: (value) {
                  _toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language', style: TextStyle(fontSize: 18)),
              const Spacer(),
              DropdownButton(
                value: _language,
                items: [
                  const DropdownMenuItem(child: Text('English'), value: 'English'),
                  const DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  const DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (String? value) {
                  _changeLanguage(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}