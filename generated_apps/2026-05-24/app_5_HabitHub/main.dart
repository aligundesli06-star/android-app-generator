import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitHub',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<String> _habits = [];
  final List<bool> _habitStatus = [];

  void _addHabit() {
    setState(() {
      _habits.add('New Habit');
      _habitStatus.add(false);
    });
  }

  void _toggleHabit(int index) {
    setState(() {
      _habitStatus[index] = !_habitStatus[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? HomeScreen(
              habits: _habits,
              habitStatus: _habitStatus,
              toggleHabit: _toggleHabit,
            )
          : _currentIndex == 1
              ? ProgressScreen(habits: _habits)
              : SettingsScreen(
                  isDarkMode: _isDarkMode,
                  language: _language,
                  toggleDarkMode: (value) {
                    setState(() {
                      _isDarkMode = value;
                      if (_isDarkMode) {
                        runApp(
                          MaterialApp(
                            title: 'HabitHub',
                            theme: ThemeData.dark().copyWith(
                              primarySwatch: Colors.indigo,
                            ),
                            home: const MyHomePage(),
                          ),
                        );
                      } else {
                        runApp(
                          MaterialApp(
                            title: 'HabitHub',
                            theme: ThemeData(
                              primarySwatch: Colors.indigo,
                            ),
                            home: const MyHomePage(),
                          ),
                        );
                      }
                    });
                  },
                  changeLanguage: (value) {
                    setState(() {
                      _language = value;
                    });
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: _addHabit,
              tooltip: 'Add Habit',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> habits;
  final List<bool> habitStatus;
  final Function(int) toggleHabit;

  const HomeScreen({
    Key? key,
    required this.habits,
    required this.habitStatus,
    required this.toggleHabit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Checkbox(
                    value: habitStatus[index],
                    onChanged: (value) => toggleHabit(index),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      habits[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const Icon(Icons.check),
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
  final List<String> habits;

  const ProgressScreen({
    Key? key,
    required this.habits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Progress',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Completed: '),
              Text('0'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Total: '),
              Text('0'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) toggleDarkMode;
  final Function(String) changeLanguage;

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
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode: '),
              Switch(
                value: isDarkMode,
                onChanged: toggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language: '),
              DropdownButton<String>(
                value: language,
                onChanged: changeLanguage,
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Turkish', child: Text('Turkish')),
                  DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}