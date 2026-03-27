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
  bool isDarkMode = false;
  String language = 'English';
  int _currentIndex = 0;

  final List<Recipe> _recipes = [
    const Recipe(
      title: 'Grilled Chicken',
      ingredients: ['Chicken breast', 'Salt', 'Pepper', 'Olive oil'],
      instructions: [
        'Preheat the grill to medium-high heat.',
        'Season the chicken with salt and pepper.',
        'Grill the chicken for 5-6 minutes per side.',
      ],
    ),
    const Recipe(
      title: 'Vegetable Soup',
      ingredients: ['Carrots', 'Potatoes', 'Onions', 'Vegetable broth'],
      instructions: [
        'Chop the vegetables into small pieces.',
        'Heat the vegetable broth in a pot.',
        'Add the chopped vegetables and simmer for 20 minutes.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(recipes: _recipes),
            ProgressScreen(),
            SettingsScreen(
              onToggleDarkMode: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              onLanguageChange: (value) {
                setState(() {
                  language = value;
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
            setState(() {
              _recipes.add(const Recipe(
                title: 'New Recipe',
                ingredients: ['Ingredient 1', 'Ingredient 2'],
                instructions: ['Instruction 1', 'Instruction 2'],
              ));
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Recipe {
  final String title;
  final List<String> ingredients;
  final List<String> instructions;

  const Recipe({
    required this.title,
    required this.ingredients,
    required this.instructions,
  });
}

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const HomeScreen({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: recipes
          .map((recipe) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text('Ingredients:'),
                      const SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recipe.ingredients
                            .map((ingredient) => Text(ingredient))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      Text('Instructions:'),
                      const SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recipe.instructions
                            .map((instruction) => Text(instruction))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.bar_chart),
            Text('Progress Screen'),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onToggleDarkMode;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.onToggleDarkMode,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Dark Mode'),
            Switch(
              value: true,
              onChanged: onToggleDarkMode,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Language'),
            DropdownButton<String>(
              value: 'English',
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
    );
  }
}