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
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitnessPal',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData(primarySwatch: Colors.indigo),
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
          onPressed: () {
            // Add new item
          },
          tooltip: 'Add new item',
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
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.fitness_center, size: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Workout Routine', style: TextStyle(fontSize: 18)),
                      Text('3 exercises, 30 minutes'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.restaurant, size: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Meal Plan', style: TextStyle(fontSize: 18)),
                      Text('3 meals, 2 snacks'),
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Indicator(text: 'Workouts', value: '10'),
              Indicator(text: 'Minutes', value: '300'),
              Indicator(text: 'Calories', value: '2000'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Indicator(text: 'Weight', value: '70kg'),
              Indicator(text: 'BMI', value: '25'),
              Indicator(text: 'Goal', value: '65kg'),
            ],
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String text;
  final String value;

  const Indicator({super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 24)),
      ],
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
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark Mode', style: TextStyle(fontSize: 18)),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  MyAppState().setState(() {
                    MyAppState()._isDarkMode = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Language', style: TextStyle(fontSize: 18)),
              DropdownButton(
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value as String;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyAppState {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  setState(VoidCallback fn) {
    // ignore: invalid_use_of_protected_member
    MyApp().createElement().setState(fn);
  }
}