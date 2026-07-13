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

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(
              toggleTheme: _toggleTheme,
              changeLanguage: _changeLanguage,
              locale: _locale,
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
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Progress',
              icon: Icon(Icons.bar_chart),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.restaurant, size: 48),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Recipe Title',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('Description'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.dinner, size: 48),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Recipe Title',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('Description'),
                    ],
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text('Progress'),
                      Text('50%'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text('Progress'),
                      Text('75%'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text('Progress'),
                      Text('25%'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text('Progress'),
                      Text('100%'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function toggleTheme;
  final Function changeLanguage;
  final Locale locale;

  const SettingsScreen({
    Key? key,
    required this.toggleTheme,
    required this.changeLanguage,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('Dark Mode'),
                  const SizedBox(width: 16),
                  Switch(
                    value: locale.toString() == 'en',
                    onChanged: (value) {
                      if (value) {
                        changeLanguage(const Locale('en'));
                      } else {
                        changeLanguage(const Locale('tr'));
                      }
                    },
                  ),
                  Switch(
                    value: locale.toString() != 'en',
                    onChanged: (value) {
                      if (value) {
                        changeLanguage(const Locale('tr'));
                      } else {
                        changeLanguage(const Locale('es'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('Language'),
                  const SizedBox(width: 16),
                  DropdownButton(
                    value: locale.toString(),
                    onChanged: (String? value) {
                      if (value == 'en') {
                        changeLanguage(const Locale('en'));
                      } else if (value == 'tr') {
                        changeLanguage(const Locale('tr'));
                      } else if (value == 'es') {
                        changeLanguage(const Locale('es'));
                      }
                    },
                    items: [
                      const DropdownMenuItem(
                        child: Text('English'),
                        value: 'en',
                      ),
                      const DropdownMenuItem(
                        child: Text('Turkish'),
                        value: 'tr',
                      ),
                      const DropdownMenuItem(
                        child: Text('Spanish'),
                        value: 'es',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('Theme'),
                  const SizedBox(width: 16),
                  Switch(
                    value: locale.toString() == 'en',
                    onChanged: (value) {
                      toggleTheme();
                    },
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