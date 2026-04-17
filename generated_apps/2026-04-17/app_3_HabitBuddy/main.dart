import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
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

  final List<Habit> _habits = [
    Habit('Morning Run', Icons.directions_run, true),
    Habit('Reading', Icons.book, false),
    Habit('Meditation', Icons.self_improvement, true),
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
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
  }

  void _selectLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _addHabit() {
    setState(() {
      _habits.add(Habit('New Habit', Icons.add, false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(habits: _habits),
          ProgressScreen(habits: _habits),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            language: _language,
            toggleDarkMode: _toggleDarkMode,
            selectLanguage: _selectLanguage,
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
        onPressed: _addHabit,
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Habit {
  final String title;
  final IconData icon;
  final bool isCompleted;

  Habit(this.title, this.icon, this.isCompleted);
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({super.key, required this.habits});

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
                  Icon(habits[index].icon, size: 32),
                  const SizedBox(width: 16),
                  Text(
                    habits[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Icon(
                    habits[index].isCompleted ? Icons.check : Icons.close,
                    size: 24,
                    color: habits[index].isCompleted ? Colors.green : Colors.red,
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

  const ProgressScreen({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    int completedCount = habits.where((habit) => habit.isCompleted).length;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Completed: $completedCount/${habits.length}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Icon(
                Icons.bar_chart,
                size: 32,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Icon(
                      habits[index].icon,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Text(habits[index].title),
                    const Spacer(),
                    Icon(
                      habits[index].isCompleted ? Icons.check : Icons.close,
                      size: 24,
                      color: habits[index].isCompleted ? Colors.green : Colors.red,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final VoidCallback toggleDarkMode;
  final void Function(String) selectLanguage;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.selectLanguage,
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
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton<String>(
                value: language,
                onChanged: (value) {
                  selectLanguage(value!);
                },
                items: const [
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'Turkish',
                    child: Text('Turkish'),
                  ),
                  DropdownMenuItem(
                    value: 'Spanish',
                    child: Text('Spanish'),
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