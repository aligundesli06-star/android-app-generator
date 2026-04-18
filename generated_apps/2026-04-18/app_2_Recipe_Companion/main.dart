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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');
  int _currentIndex = 0;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      if (language == 'English') {
        _locale = const Locale('en');
      } else if (language == 'Turkish') {
        _locale = const Locale('tr');
      } else if (language == 'Spanish') {
        _locale = const Locale('es');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Recipe> _recipes = [
    Recipe('Grilled Chicken', 'Grilled chicken breast with roasted vegetables', 'assets/chicken.jpg'),
    Recipe('Pasta', 'Pasta with marinara sauce and melted mozzarella cheese', 'assets/pasta.jpg'),
    Recipe('Salad', 'Mixed greens with cherry tomatoes and balsamic vinaigrette', 'assets/salad.jpg'),
  ];

  final List<ProgressIndicator> _progressIndicators = [
    ProgressIndicator('Cooking', 50),
    ProgressIndicator('Cleaning', 20),
    ProgressIndicator('Shopping', 80),
  ];

  void _addNewItem() {
    setState(() {
      _recipes.add(Recipe('New Recipe', 'New recipe description', 'assets/new_recipe.jpg'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(_recipes),
          ProgressScreen(_progressIndicators),
          SettingsScreen((theme) {
            setState(() {
              _themeMode = theme;
            });
          }, (language) {
            setState(() {
              if (language == 'English') {
                _locale = const Locale('en');
              } else if (language == 'Turkish') {
                _locale = const Locale('tr');
              } else if (language == 'Spanish') {
                _locale = const Locale('es');
              }
            });
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        tooltip: 'Add new item',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Recipe {
  final String title;
  final String description;
  final String imageUrl;

  Recipe(this.title, this.description, this.imageUrl);
}

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;

  HomeScreen(this.recipes);

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
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    recipes[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(recipes[index].description),
                  Image.asset(recipes[index].imageUrl),
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
  final List<ProgressIndicator> progressIndicators;

  ProgressScreen(this.progressIndicators);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: progressIndicators
            .map((progressIndicator) => Row(
                  children: [
                    Text(progressIndicator.title),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progressIndicator.progress / 100,
                      ),
                    ),
                    Text('${progressIndicator.progress}%'),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

class ProgressIndicator {
  final String title;
  final int progress;

  ProgressIndicator(this.title, this.progress);
}

class SettingsScreen extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;
  final Function(String) onLanguageChanged;

  SettingsScreen(this.onThemeChanged, this.onLanguageChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Theme'),
              Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  onThemeChanged(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language'),
              DropdownButton(
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
                  onLanguageChanged(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}