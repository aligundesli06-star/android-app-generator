import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDark = false;
  String _language = 'English';
  List< HabitItem > _habits = [];

  void _addHabit() {
    setState(() {
      _habits.add(HabitItem(title: 'New Habit', icon: Icons.run));
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDark = !_isDark;
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
      title: 'HabitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_habits),
            ProgressScreen(_habits),
            SettingsScreen(_language, _toggleDarkMode, _changeLanguage),
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
          onPressed: _addHabit,
          tooltip: 'Add Habit',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HabitItem {
  final String title;
  final IconData icon;

  HabitItem({required this.title, required this.icon});
}

class HomeScreen extends StatelessWidget {
  final List< HabitItem > _habits;

  HomeScreen(this._habits);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(_habits[index].icon),
                  SizedBox(width: 16),
                  Text(_habits[index].title, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List< HabitItem > _habits;

  ProgressScreen(this._habits);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Habit Progress', style: TextStyle(fontSize: 18)),
              SizedBox(width: 16),
              Icon(Icons.bar_chart),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: _habits.map((habit) {
              return Row(
                children: [
                  Icon(habit.icon),
                  SizedBox(width: 16),
                  Text(habit.title, style: TextStyle(fontSize: 18)),
                  SizedBox(width: 16),
                  Text('Progress: 50%', style: TextStyle(fontSize: 18)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String _language;
  final VoidCallback _toggleDarkMode;
  final Function(String) _changeLanguage;

  SettingsScreen(this._language, this._toggleDarkMode, this._changeLanguage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Language', style: TextStyle(fontSize: 18)),
              SizedBox(width: 16),
              DropdownButton(
                value: _language,
                onChanged: (String? value) {
                  _changeLanguage(value!);
                },
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
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Dark Mode', style: TextStyle(fontSize: 18)),
              SizedBox(width: 16),
              Switch(
                value: _language == 'English',
                onChanged: (bool value) {
                  _toggleDarkMode();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}