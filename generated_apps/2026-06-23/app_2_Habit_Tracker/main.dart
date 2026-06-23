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
  String _selectedLanguage = 'en';
  List<Habit> _habits = [
    Habit('Exercise', '30 minutes', true),
    Habit('Meditation', '10 minutes', false),
    Habit('Reading', '1 hour', true),
  ];
  final _controller = TextEditingController();

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _addHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Habit'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Habit Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  _habits.add(Habit(_controller.text, '', false));
                  _controller.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              habits: _habits,
              onAddHabit: _addHabit,
            ),
            ProgressScreen(
              habits: _habits,
            ),
            SettingsScreen(
              onToggleDarkMode: _toggleDarkMode,
              selectedLanguage: _selectedLanguage,
              onLanguageChange: (language) {
                setState(() {
                  _selectedLanguage = language;
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String name;
  final String duration;
  final bool isCompleted;

  Habit(this.name, this.duration, this.isCompleted);
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final VoidCallback onAddHabit;

  const HomeScreen({
    Key? key,
    required this.habits,
    required this.onAddHabit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.check_circle),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habits[index].name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        habits[index].duration,
                        style: const TextStyle(fontSize: 14),
                      ),
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
  final List<Habit> habits;

  const ProgressScreen({
    Key? key,
    required this.habits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text(
                'Progress',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.check),
              const SizedBox(width: 16),
              Text(
                'Completed: ${habits.where((habit) => habit.isCompleted).length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.clear),
              const SizedBox(width: 16),
              Text(
                'Not Completed: ${habits.where((habit) => !habit.isCompleted).length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback onToggleDarkMode;
  final String selectedLanguage;
  final void Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.onToggleDarkMode,
    required this.selectedLanguage,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.toggle_off),
              const SizedBox(width: 16),
              Text(
                'Dark Mode',
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Switch(
                value: true,
                onChanged: (value) {
                  onToggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              Text(
                'Language',
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              DropdownButton(
                value: selectedLanguage,
                onChanged: onLanguageChange,
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