import 'dart:async';
import 'package:flutter/material.dart';

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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  final _habitList = [
    {'name': 'Morning Exercise', 'icon': Icons.directions_run},
    {'name': 'Reading', 'icon': Icons.book},
    {'name': 'Meditation', 'icon': Icons.self_improvement},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Builder',
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Habit Builder'),
        ),
        body: _currentIndex == 0
            ? const HomeScreen()
            : _currentIndex == 1
                ? const ProgressScreen()
                : const SettingsScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add New Habit'),
                content: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Habit Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _habitList.add({
                            'name': 'New Habit',
                            'icon': Icons.directions_run,
                          }));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.directions_run),
                  SizedBox(width: 16),
                  Text('Morning Exercise'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.book),
                  SizedBox(width: 16),
                  Text('Reading'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.self_improvement),
                  SizedBox(width: 16),
                  Text('Meditation'),
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Success'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Failure'),
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
  bool _darkMode = false;
  String _language = 'en';

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
                value: _darkMode,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                    if (_darkMode) {
                      context.findAncestorStateOfType<_MyAppState>()?._themeMode =
                          ThemeMode.dark;
                    } else {
                      context.findAncestorStateOfType<_MyAppState>()?._themeMode =
                          ThemeMode.light;
                    }
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
              DropdownButton(
                value: _language,
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                    if (_language == 'en') {
                      context.findAncestorStateOfType<_MyAppState>()?._locale =
                          const Locale('en');
                    } else if (_language == 'tr') {
                      context.findAncestorStateOfType<_MyAppState>()?._locale =
                          const Locale('tr');
                    } else if (_language == 'es') {
                      context.findAncestorStateOfType<_MyAppState>()?._locale =
                          const Locale('es');
                    }
                  });
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'es',
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