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
  int _currentIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'Recipe Book',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      home: HomeScreen(
        onNavigation: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        onThemeChange: (mode) => setState(() => _themeMode = mode),
        onLanguageChange: (locale) => setState(() => _locale = locale),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigation;
  final int currentIndex;
  final Function(ThemeMode) onThemeChange;
  final Function(Locale) onLanguageChange;

  const HomeScreen({
    Key? key,
    required this.onNavigation,
    required this.currentIndex,
    required this.onThemeChange,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Recipe> _recipes = const [
    Recipe(
      title: 'Grilled Chicken',
      description: 'A healthy and delicious dish',
      icon: Icons.food_bank,
    ),
    Recipe(
      title: 'Vegetable Stew',
      description: 'A hearty and nourishing meal',
      icon: Icons.local_dining,
    ),
    Recipe(
      title: 'Fresh Salad',
      description: 'A refreshing and light option',
      icon: Icons.restaurant,
    ),
  ];

  void _addRecipe() {
    setState(() {
      _recipes.add(
        Recipe(
          title: 'New Recipe',
          description: 'A new and exciting dish',
          icon: Icons.add,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _recipes[index].icon,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _recipes[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _recipes[index].description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (index) => widget.onNavigation(index),
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
    );
  }
}

class Recipe {
  final String title;
  final String description;
  final IconData icon;

  const Recipe({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.local_dining),
              const SizedBox(width: 16),
              Text(
                'Meals Cooked: 10',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.favorite),
              const SizedBox(width: 16),
              Text(
                'Favorite Recipes: 5',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChange;
  final Function(Locale) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.onThemeChange,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.format_color_reset),
              const SizedBox(width: 16),
              Text(
                'Theme',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: _themeMode == ThemeMode.light,
                onChanged: (value) => setState(() {
                  _themeMode = value ? ThemeMode.light : ThemeMode.dark;
                  widget.onThemeChange(_themeMode);
                }),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButton<Locale>(
                value: _locale,
                onChanged: (value) => setState(() {
                  _locale = value ?? const Locale('en');
                  widget.onLanguageChange(_locale);
                }),
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: Text('Español'),
                    value: Locale('es'),
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