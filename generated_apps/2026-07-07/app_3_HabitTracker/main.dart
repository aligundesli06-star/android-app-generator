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
  String _language = 'English';
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitTracker',
      theme: _darkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: HomePage(
        currentIndex: _currentIndex,
        language: _language,
        darkMode: _darkMode,
        onSettingChanged: (language, darkMode) {
          setState(() {
            _language = language;
            _darkMode = darkMode;
          });
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final int currentIndex;
  final String language;
  final bool darkMode;
  final void Function(String, bool) onSettingChanged;

  const HomePage({
    Key? key,
    required this.currentIndex,
    required this.language,
    required this.darkMode,
    required this.onSettingChanged,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Habit> _habits = [
    Habit('Exercise', Icons.directions_run, '45 minutes'),
    Habit('Meditation', Icons.accessibility, '10 minutes'),
    Habit('Reading', Icons.book, '30 minutes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitTracker'),
      ),
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(habits: _habits),
          ProgressScreen(habits: _habits),
          SettingsScreen(
            language: widget.language,
            darkMode: widget.darkMode,
            onSettingChanged: (language, darkMode) {
              widget.onSettingChanged(language, darkMode);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(habit.icon),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(habit.title, style: Theme.of(context).textTheme.titleLarge),
                      Text(habit.description),
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

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits.map((habit) {
          return Row(
            children: [
              Icon(habit.icon),
              const SizedBox(width: 16),
              Text(habit.title, style: Theme.of(context).textTheme.titleLarge),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String language;
  final bool darkMode;
  final void Function(String, bool) onSettingChanged;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.darkMode,
    required this.onSettingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: language,
                onChanged: (value) {
                  onSettingChanged(value!, darkMode);
                },
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: darkMode,
                onChanged: (value) {
                  onSettingChanged(language, value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Habit Title',
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Habit Description',
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: null,
              hint: const Text('Select Icon'),
              onChanged: (value) {},
              items: const [
                DropdownMenuItem(child: Text('Run'), value: 'run'),
                DropdownMenuItem(child: Text('Meditation'), value: 'meditation'),
                DropdownMenuItem(child: Text('Book'), value: 'book'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Habit {
  final String title;
  final IconData icon;
  final String description;

  Habit(this.title, this.icon, this.description);
}