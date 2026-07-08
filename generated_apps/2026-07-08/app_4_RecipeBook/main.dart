import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<String> _recipes = [
    'Recipe 1',
    'Recipe 2',
    'Recipe 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentIndex == 0
            ? GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: _recipes
                    .map((recipe) => Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.restaurant_menu,
                                  size: 40,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  recipe,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              )
            : _currentIndex == 1
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.bar_chart,
                              size: 40,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Progress',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          children: List.generate(
                            6,
                            (index) => Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Indicator $index',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 40,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Settings',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _isDarkMode = value;
                          });
                        },
                      ),
                      Text(
                        'Theme: ${_isDarkMode ? 'Dark' : 'Light'}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      DropdownButton(
                        value: _language,
                        onChanged: (value) {
                          setState(() {
                            _language = value as String;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            child: Text('English'),
                            value: 'English',
                          ),
                          DropdownMenuItem(
                            child: Text('Türkçe'),
                            value: 'Turkish',
                          ),
                          DropdownMenuItem(
                            child: Text('Español'),
                            value: 'Spanish',
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
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
            _recipes.add('Recipe ${_recipes.length + 1}');
          });
        },
        tooltip: 'Add Recipe',
        child: const Icon(Icons.add),
      ),
    );
  }
}