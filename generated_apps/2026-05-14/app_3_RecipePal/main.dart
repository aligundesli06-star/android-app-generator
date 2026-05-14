import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RecipePalApp();
  }
}

class RecipePalApp extends StatefulWidget {
  const RecipePalApp({Key? key}) : super(key: key);

  @override
  State<RecipePalApp> createState() => _RecipePalAppState();
}

class _RecipePalAppState extends State<RecipePalApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<Recipe> _recipes = [
    Recipe(
      title: 'Grilled Chicken',
      description: 'Marinated chicken breast grilled to perfection',
      cookingTime: 30,
      servingSize: 4,
    ),
    Recipe(
      title: 'Spinach and Feta Stuffed Chicken',
      description: 'Chicken breast stuffed with spinach and feta cheese',
      cookingTime: 45,
      servingSize: 4,
    ),
    Recipe(
      title: 'Beef and Broccoli Stir Fry',
      description: 'Stir fry of beef and broccoli in a savory sauce',
      cookingTime: 20,
      servingSize: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipePal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RecipePal'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              recipes: _recipes,
              onAddRecipe: () {
                setState(() {
                  _recipes.add(
                    Recipe(
                      title: 'New Recipe',
                      description: 'Description',
                      cookingTime: 0,
                      servingSize: 0,
                    ),
                  );
                });
              },
            ),
            ProgressScreen(),
            SettingsScreen(
              onToggleDarkMode: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
              onLanguageChange: (language) {
                setState(() {
                  _language = language;
                });
              },
              isDarkMode: _isDarkMode,
              language: _language,
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
              _recipes.add(
                Recipe(
                  title: 'New Recipe',
                  description: 'Description',
                  cookingTime: 0,
                  servingSize: 0,
                ),
              );
            });
          },
          tooltip: 'Add Recipe',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final VoidCallback onAddRecipe;

  const HomeScreen({
    Key? key,
    required this.recipes,
    required this.onAddRecipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Discover Recipes',
            style: TextStyle(fontSize: 24),
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
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipes[index].title,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                recipes[index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.timer),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipes[index].cookingTime} minutes',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.group),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipes[index].servingSize} servings',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.favorite_border),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Your Progress',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'Recipes Cooked',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '10',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Cooking Time',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '5 hours',
                    style: TextStyle(fontSize: 24),
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

class SettingsScreen extends StatelessWidget {
  final VoidCallback onToggleDarkMode;
  final void Function(String) onLanguageChange;
  final bool isDarkMode;
  final String language;

  const SettingsScreen({
    Key? key,
    required this.onToggleDarkMode,
    required this.onLanguageChange,
    required this.isDarkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onToggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  onLanguageChange(value as String);
                },
                items: [
                  const DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  const DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  const DropdownMenuItem(
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

class Recipe {
  final String title;
  final String description;
  final int cookingTime;
  final int servingSize;

  Recipe({
    required this.title,
    required this.description,
    required this.cookingTime,
    required this.servingSize,
  });
}