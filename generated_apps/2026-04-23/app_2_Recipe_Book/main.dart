import 'package:flutter/material.dart';
import 'dart:async';

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
  List<Recipe> _recipes = [
    Recipe('Recipe 1', 'Description 1', 'https://via.placeholder.com/200'),
    Recipe('Recipe 2', 'Description 2', 'https://via.placeholder.com/200'),
    Recipe('Recipe 3', 'Description 3', 'https://via.placeholder.com/200'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: _body(_currentIndex),
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
            setState(() {
              _recipes.add(Recipe('New Recipe', 'New Description', 'https://via.placeholder.com/200'));
            });
          },
          tooltip: 'Add Recipe',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _body(int index) {
    if (index == 0) return const HomeScreen(recipes: []);
    if (index == 1) return const ProgressScreen();
    if (index == 2) return const SettingsScreen();
    return Container();
  }
}

class HomeScreen extends StatefulWidget {
  final List<Recipe> recipes;

  const HomeScreen({super.key, required this.recipes});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: widget.recipes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(widget.recipes[index].imageUrl, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.recipes[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.recipes[index].description,
                    style: Theme.of(context).textTheme.bodyText1,
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: ProgressIndicator(
                  value: 0.2,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(width: 16),
              Text('20%'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: ProgressIndicator(
                  value: 0.5,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(width: 16),
              Text('50%'),
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
  bool _isDarkMode = false;
  String _language = 'English';

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
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  ThemeMode themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
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
                  setState(() {
                    _language = value as String;
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

class Recipe {
  final String name;
  final String description;
  final String imageUrl;

  Recipe(this.name, this.description, this.imageUrl);
}

class ProgressIndicator extends StatelessWidget {
  final double value;
  final Color color;

  const ProgressIndicator({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: Colors.grey[200],
      color: color,
      minHeight: 16,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    );
  }
}