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

  final List<_Habit> _habits = [
    _Habit('Exercise', '30 minutes', Icons.directions_run),
    _Habit('Meditation', '10 minutes', Icons.self_improvement),
    _Habit('Reading', '1 hour', Icons.book),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_habits, _addHabit),
            ProgressScreen(_habits),
            SettingsScreen(_toggleDarkMode, _changeLanguage),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addHabit,
          tooltip: 'New Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addHabit() {
    final _newHabit = _Habit('New Habit', '1 hour', Icons.directions_bike);
    setState(() => _habits.add(_newHabit));
  }

  void _toggleDarkMode() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  void _changeLanguage(String language) {
    setState(() => _selectedLanguage = language);
  }
}

class HomeScreen extends StatelessWidget {
  final List<_Habit> _habits;
  final Function _addHabit;

  const HomeScreen(this._habits, this._addHabit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(_habits[index].icon),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_habits[index].name, style: Theme.of(context).textTheme.titleLarge),
                      Text(_habits[index].duration),
                    ],
                  ),
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
  final List<_Habit> _habits;

  const ProgressScreen(this._habits, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _habits.map((habit) {
          return Row(
            children: [
              Expanded(child: Text(habit.name)),
              const SizedBox(width: 16),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function _toggleDarkMode;
  final Function _changeLanguage;

  const SettingsScreen(this._toggleDarkMode, this._changeLanguage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: Text('Dark Mode')),
              Switch(
                value: _isDarkMode(context),
                onChanged: (value) => _toggleDarkMode(),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Language')),
              DropdownButton(
                value: _getSelectedLanguage(context),
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) => _changeLanguage(value as String),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isDarkMode(BuildContext context) {
    final MyApp myApp = context.findAncestorWidgetOfExactType<MyApp>() as MyApp;
    return myApp._isDarkMode;
  }

  String _getSelectedLanguage(BuildContext context) {
    final MyApp myApp = context.findAncestorWidgetOfExactType<MyApp>() as MyApp;
    return myApp._selectedLanguage;
  }
}

class _Habit {
  final String name;
  final String duration;
  final IconData icon;

  _Habit(this.name, this.duration, this.icon);
}