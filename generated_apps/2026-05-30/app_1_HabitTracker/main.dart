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

  final List<Habit> _habits = [
    Habit(id: 1, title: 'Exercise', isCompleted: true),
    Habit(id: 2, title: 'Meditation', isCompleted: false),
    Habit(id: 3, title: 'Reading', isCompleted: true),
  ];

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
      _habits.add(Habit(id: _habits.length + 1, title: 'New Habit', isCompleted: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habits: _habits),
            ProgressScreen(habits: _habits),
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
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: const Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'Settings'),
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
  final int id;
  final String title;
  final bool isCompleted;

  Habit({required this.id, required this.title, required this.isCompleted});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: habits.length,
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
                  Icon(habits[index].isCompleted ? Icons.check_circle : Icons.circle),
                  const SizedBox(width: 16),
                  Text(
                    habits[index].title,
                    style: const TextStyle(fontSize: 18),
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

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits.map((habit) {
          return Row(
            children: [
              Text(
                habit.title,
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Icon(habit.isCompleted ? Icons.check : Icons.close),
            ],
          );
        }).toList(),
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
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) => toggleDarkMode(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: language,
                onChanged: (value) => changeLanguage(value),
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
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