import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme();
  }
}

class DynamicTheme extends StatefulWidget {
  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              isDarkMode: _isDarkMode,
              language: _language,
              onChanged: (isDarkMode, language) {
                setState(() {
                  _isDarkMode = isDarkMode;
                  _language = language;
                });
              },
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
  int _currentIndex = 0;

  final List<String> _recipes = [
    'Breakfast',
    'Lunch',
    'Dinner',
  ];

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProgressScreen(),
    const Text('Settings'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 2) {
      Navigator.pushNamed(
        context,
        '/settings',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _pages[_currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: [
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(Icons.restaurant, size: 48.0),
                const Text('Breakfast Recipes'),
              ],
            ),
          ),
        ),
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(Icons.snack_bar, size: 48.0),
                const Text('Snack Recipes'),
              ],
            ),
          ),
        ),
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(Icons.local_dining, size: 48.0),
                const Text('Dinner Recipes'),
              ],
            ),
          ),
        ),
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(Icons.dessert, size: 48.0),
                const Text('Dessert Recipes'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Progress:',
              style: TextStyle(fontSize: 24.0),
            ),
            Spacer(),
            Text(
              '75%',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        LinearProgressIndicator(
          value: 0.75,
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool, String) onChanged;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onChanged,
  }) : super(key: key);

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
                const Text('Dark Mode:'),
                const Spacer(),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) => onChanged(value, language),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Language:'),
                const Spacer(),
                DropdownButton<String>(
                  value: language,
                  onChanged: (value) => onChanged(isDarkMode, value!),
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
        ),
      ),
    );
  }
}