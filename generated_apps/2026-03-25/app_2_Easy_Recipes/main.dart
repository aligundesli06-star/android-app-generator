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
      title: 'Easy Recipes',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const ProgressScreen(),
        SettingsScreen(
          onDarkModeChanged: (value) {
            setState(() {
              _isDarkMode = value;
            });
          },
          onLanguageChanged: (value) {
            setState(() {
              _language = value;
            });
          },
        ),
      ][_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
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
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.restaurant),
                      SizedBox(width: 8),
                      Text('Recipe 1'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('This is a recipe description'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.restaurant),
                      SizedBox(width: 8),
                      Text('Recipe 2'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('This is another recipe description'),
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
              const Icon(Icons.bar_chart),
              const SizedBox(width: 8),
              const Text('Progress'),
              const Spacer(),
              const Text('75%'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 8),
              const Text('Goal'),
              const Spacer(),
              const Text('100%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final void Function(bool) onDarkModeChanged;
  final void Function(String) onLanguageChanged;

  const SettingsScreen({
    super.key,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  widget.onDarkModeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                  });
                  widget.onLanguageChanged(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}