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
  bool _isDarkMode = false;
  String _language = 'English';
  List<String> habits = ['Exercise', 'Meditation', 'Reading'];

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

  void _addHabit() {
    setState(() {
      habits.add('New Habit');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      darkTheme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              scaffoldBackgroundColor: Colors.grey[900],
            )
          : null,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habits: habits),
            ProgressScreen(habits: habits),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              toggleDarkMode: _toggleDarkMode,
              changeLanguage: _changeLanguage,
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addHabit,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: habits
            .map(
              (habit) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 40.0,
                      ),
                      Text(
                        habit,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        'Daily',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<String> habits;

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits
            .map(
              (habit) => Row(
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 40.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$habit Progress',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  Text(
                    '75%',
                    style: TextStyle(fontSize: 18.0, color: Colors.green),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function toggleDarkMode;
  final Function changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  }) : super(key: key);

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
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Spacer(),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) => toggleDarkMode(),
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Language',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Spacer(),
                  DropdownButton(
                    value: language,
                    items: [
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
                    onChanged: (value) => changeLanguage(value),
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