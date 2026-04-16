import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeRouletteApp());
}

class RecipeRouletteApp extends StatefulWidget {
  const RecipeRouletteApp({super.key});

  @override
  State<RecipeRouletteApp> createState() => _RecipeRouletteAppState();
}

class _RecipeRouletteAppState extends State<RecipeRouletteApp> {
  int _currentIndex = 0;
  String _language = 'English';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
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
            // Add new item
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.recipe),
                      SizedBox(width: 16),
                      Text('Recipe Suggestion'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Discover new recipes and cooking ideas'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 16),
                      Text('Grocery List'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Manage your grocery list and track your progress'),
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress Indicators'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Progress:'),
              const SizedBox(width: 16),
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
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
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.settings),
              SizedBox(width: 16),
              Text('Settings'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'Turkish',
                    child: Text('Turkish'),
                  ),
                  DropdownMenuItem(
                    value: 'Spanish',
                    child: Text('Spanish'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}