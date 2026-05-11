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
  int currentIndex = 0;
  bool isDarkMode = false;
  String language = 'English';

  void setLanguage(String lang) {
    setState(() {
      language = lang;
    });
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitHub',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: MyHomePage(
        currentIndex: currentIndex,
        isDarkMode: isDarkMode,
        language: language,
        toggleDarkMode: toggleDarkMode,
        setLanguage: setLanguage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final bool isDarkMode;
  final String language;
  final Function toggleDarkMode;
  final Function setLanguage;

  const MyHomePage({
    Key? key,
    required this.currentIndex,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.setLanguage,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _habits = [
    {'title': 'Morning Exercise', 'icon': Icons.directions_run},
    {'title': 'Meditation', 'icon': Icons.meditation},
    {'title': 'Reading', 'icon': Icons.book},
  ];

  void _addNewHabit() {
    setState(() {
      _habits.add({'title': 'New Habit', 'icon': Icons.add});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            habits: _habits,
            isDarkMode: widget.isDarkMode,
            language: widget.language,
          ),
          ProgressScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
          ),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            toggleDarkMode: widget.toggleDarkMode,
            setLanguage: widget.setLanguage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
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
        onPressed: _addNewHabit,
        tooltip: 'Add New Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> habits;
  final bool isDarkMode;
  final String language;

  const HomeScreen({
    Key? key,
    required this.habits,
    required this.isDarkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits.map((habit) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    habit['icon'],
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    habit['title'],
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;

  const ProgressScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Days:'),
              SizedBox(width: 16),
              Text('7'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Streak:'),
              SizedBox(width: 16),
              Text('3'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function toggleDarkMode;
  final Function setLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.setLanguage,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.language,
                onChanged: (String? value) {
                  widget.setLanguage(value);
                },
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