import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const FocusFlow();
  }
}

class FocusFlow extends StatefulWidget {
  const FocusFlow({super.key});

  @override
  State<FocusFlow> createState() => _FocusFlowState();
}

class _FocusFlowState extends State<FocusFlow> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final _focusFlowItems = [
    FocusFlowItem(
      title: 'Work Session 1',
      description: 'Focus on task 1 for 25 minutes',
      duration: 25,
    ),
    FocusFlowItem(
      title: 'Break Time',
      description: 'Take a 5-minute break',
      duration: 5,
    ),
    FocusFlowItem(
      title: 'Work Session 2',
      description: 'Focus on task 2 for 25 minutes',
      duration: 25,
    ),
  ];

  void _addNewItem() {
    setState(() {
      _focusFlowItems.add(
        FocusFlowItem(
          title: 'New Item',
          description: 'New item description',
          duration: 25,
        ),
      );
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusFlow',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
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
          onPressed: _addNewItem,
          tooltip: 'Add new item',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class FocusFlowItem {
  final String title;
  final String description;
  final int duration;

  FocusFlowItem({required this.title, required this.description, required this.duration});
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
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.work),
                  SizedBox(width: 16),
                  Text(
                    'Work Session 1',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.timer),
                  SizedBox(width: 16),
                  Text(
                    '25 minutes',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.description),
                  SizedBox(width: 16),
                  Text(
                    'Focus on task 1 for 25 minutes',
                    style: TextStyle(fontSize: 18),
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text(
                'Progress',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Work Sessions: 2',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text(
                'Breaks: 1',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Total Focus Time: 50 minutes',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text(
                'Total Break Time: 5 minutes',
                style: TextStyle(fontSize: 18),
              ),
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
  bool _isDarkMode = false;
  String _language = 'English';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.dark_mode),
              const SizedBox(width: 16),
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.translate),
              const SizedBox(width: 16),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButton(
                value: _language,
                onChanged: (value) {
                  _changeLanguage(value as String);
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