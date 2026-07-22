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

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(primarySwatch: Colors.indigo),
      darkTheme: ThemeData(primarySwatch: Colors.indigo, brightness: Brightness.dark),
      themeMode: _themeMode,
      locale: _locale,
      home: HomeScreen(
        toggleTheme: _toggleTheme,
        changeLocale: _changeLocale,
        locale: _locale,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;
  final Function changeLocale;
  final Locale locale;

  const HomeScreen({
    Key? key,
    required this.toggleTheme,
    required this.changeLocale,
    required this.locale,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Home(),
          Progress(),
          Settings(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add new recipe',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: List.generate(
          10,
          (index) => Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.restaurant, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Recipe',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Description of the recipe',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Progress',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.bar_chart, size: 24),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              5,
              (index) => Container(
                margin: const EdgeInsets.all(8),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Settings extends StatefulWidget {
  final Function toggleTheme;
  final Function changeLocale;
  final Locale locale;

  const Settings({
    Key? key,
    required this.toggleTheme,
    required this.changeLocale,
    required this.locale,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Theme',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) => widget.toggleTheme(),
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
              const Spacer(),
              DropdownButton(
                value: widget.locale.toString(),
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: Text('Español'),
                    value: 'es',
                  ),
                ],
                onChanged: (value) {
                  if (value == 'en') {
                    widget.changeLocale(const Locale('en'));
                  } else if (value == 'tr') {
                    widget.changeLocale(const Locale('tr'));
                  } else if (value == 'es') {
                    widget.changeLocale(const Locale('es'));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}