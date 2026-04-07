import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HabitBuddyApp();
  }
}

class HabitBuddyApp extends StatefulWidget {
  @override
  State<HabitBuddyApp> createState() => _HabitBuddyAppState();
}

class _HabitBuddyAppState extends State<HabitBuddyApp> {
  int _currentIndex = 0;
  bool _isDark = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const ProgressScreen(),
            SettingsScreen(
              isDark: _isDark,
              language: _language,
              onChanged: (dark, language) {
                setState(() {
                  _isDark = dark;
                  _language = language;
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
            // add new item
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.run, size: 48),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Exercise', style: TextStyle(fontSize: 18)),
                      Text('30 minutes a day'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.book, size: 48),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Reading', style: TextStyle(fontSize: 18)),
                      Text('1 hour a day'),
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
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart, size: 24),
              const SizedBox(width: 8),
              const Text('7-Day Progress'),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: const [
              Row(
                children: [
                  Text('Monday: ', style: TextStyle(fontSize: 16)),
                  Text('Exercise: 30 minutes', style: TextStyle(fontSize: 16)),
                  Text(', Reading: 1 hour', style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Text('Tuesday: ', style: TextStyle(fontSize: 16)),
                  Text('Exercise: 30 minutes', style: TextStyle(fontSize: 16)),
                  Text(', Reading: 1 hour', style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Text('Wednesday: ', style: TextStyle(fontSize: 16)),
                  Text('Exercise: 30 minutes', style: TextStyle(fontSize: 16)),
                  Text(', Reading: 1 hour', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDark;
  final String language;
  final void Function(bool, String) onChanged;

  const SettingsScreen({
    Key? key,
    required this.isDark,
    required this.language,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode: '),
              Switch(
                value: isDark,
                onChanged: (value) {
                  onChanged(value, language);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language: '),
              const SizedBox(width: 8),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  onChanged(isDark, value as String);
                },
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}