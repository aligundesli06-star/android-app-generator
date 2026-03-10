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
  List<String> _habits = [];

  void _addHabit() {
    setState(() {
      _habits.add('New Habit ${_habits.length + 1}');
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
    return Scaffold(
      appBar: AppBar(
        title: Text('HabitBuddy'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            habits: _habits,
          ),
          ProgressScreen(
            habits: _habits,
          ),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            language: _language,
            toggleDarkMode: _toggleDarkMode,
            changeLanguage: _changeLanguage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> habits;

  const HomeScreen({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits
            .map((habit) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check_box),
                        const SizedBox(width: 16.0),
                        Text(habit),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<String> habits;

  const ProgressScreen({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16.0),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ...habits
              .map((habit) => Row(
                    children: [
                      Text(habit),
                      const SizedBox(width: 16.0),
                      Container(
                        width: 100.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final void Function() toggleDarkMode;
  final void Function(String) changeLanguage;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.dark_mode),
              const SizedBox(width: 16.0),
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) => toggleDarkMode(),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16.0),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButton<String>(
                value: language,
                onChanged: (value) => changeLanguage(value!),
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