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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      locale: _locale,
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
              onLocaleChanged: (locale) => setState(() => _locale = locale),
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Recipe> _recipes = [
    Recipe('Grilled Chicken', 'Grilled chicken with vegetables'),
    Recipe('Fried Fish', 'Fried fish with lemon'),
    Recipe('Tomato Soup', 'Delicious tomato soup'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.restaurant, size: 36),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _recipes[index].name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgressPage()),
            );
          } else if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          }
        }),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new recipe logic here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: LinearProgressIndicator(value: 0.5),
                ),
                const SizedBox(width: 16),
                Text(
                  '50%',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: LinearProgressIndicator(value: 0.8),
                ),
                const SizedBox(width: 16),
                Text(
                  '80%',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final void Function(ThemeMode) onThemeModeChanged;
  final void Function(Locale) onLocaleChanged;

  const SettingsPage({
    Key? key,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode'),
                const SizedBox(width: 16),
                Switch(
                  value: _themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    setState(() {
                      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                      widget.onThemeModeChanged(_themeMode);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const SizedBox(width: 16),
                DropdownButton<Locale>(
                  value: _locale,
                  onChanged: (locale) {
                    setState(() {
                      _locale = locale ?? const Locale('en');
                      widget.onLocaleChanged(_locale);
                    });
                  },
                  items: [
                    const DropdownMenuItem(
                      child: Text('English'),
                      value: Locale('en'),
                    ),
                    const DropdownMenuItem(
                      child: Text('Turkish'),
                      value: Locale('tr'),
                    ),
                    const DropdownMenuItem(
                      child: Text('Spanish'),
                      value: Locale('es'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Recipe {
  final String name;
  final String description;

  Recipe(this.name, this.description);
}