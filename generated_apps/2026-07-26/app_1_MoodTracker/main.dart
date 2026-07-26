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
      title: 'MoodTracker',
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
      appBar: AppBar(
        title: const Text('MoodTracker'),
      ),
      body: SafeArea(
        child: _currentIndex == 0
            ? HomeScreen(
                onAdd: () {
                  setState(() {
                    // Add new item
                  });
                },
              )
            : _currentIndex == 1
                ? ProgressScreen()
                : SettingsScreen(
                    onDarkModeChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                        if (_isDarkMode) {
                          Theme.of(context).copyWith(
                            brightness: Brightness.dark,
                          );
                        } else {
                          Theme.of(context).copyWith(
                            brightness: Brightness.light,
                          );
                        }
                      });
                    },
                    onLanguageChanged: (value) {
                      setState(() {
                        _language = value;
                      });
                    },
                  ),
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
            // Add new item
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function onAdd;

  const HomeScreen({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.sentiment_satisfied),
                      SizedBox(width: 8.0),
                      Text('Happy'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: const [
                      Icon(Icons.sentiment_neutral),
                      SizedBox(width: 8.0),
                      Text('Neutral'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: const [
                      Icon(Icons.sentiment_dissatisfied),
                      SizedBox(width: 8.0),
                      Text('Sad'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              onAdd();
            },
            child: const Text('Add New Entry'),
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade200,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Center(
                    child: Text('Progress Bar'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 8.0),
              Text('Detailed Progress'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function onDarkModeChanged;
  final Function onLanguageChanged;

  const SettingsScreen({
    super.key,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  });

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
                value: false,
                onChanged: (value) {
                  onDarkModeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: 'English',
                onChanged: (String? value) {
                  onLanguageChanged(value);
                },
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
    );
  }
}