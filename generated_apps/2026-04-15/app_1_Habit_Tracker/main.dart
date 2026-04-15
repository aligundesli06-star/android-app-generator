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
  List<Habit> _habits = [];

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

  void _addHabit(Habit habit) {
    setState(() {
      _habits.add(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
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
              isDarkMode: _isDarkMode,
              onToggleDarkMode: _toggleDarkMode,
              language: _language,
              onLanguageChange: _changeLanguage,
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
          onPressed: () {
            _addHabit(Habit(
              title: 'New Habit',
              description: 'Description',
              completed: false,
            ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String title;
  final String description;
  final bool completed;

  Habit({
    required this.title,
    required this.description,
    required this.completed,
  });
}

class HomeScreen extends StatefulWidget {
  final List<Habit> habits;
  final Function(Habit) onAddHabit;

  const HomeScreen({
    Key? key,
    required this.habits,
    required this.onAddHabit,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: widget.habits.length,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.habits[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          widget.habits[index].description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    widget.habits[index].completed
                        ? Icons.check_circle
                        : Icons.circle,
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

class ProgressScreen extends StatefulWidget {
  final List<Habit> habits;

  const ProgressScreen({
    Key? key,
    required this.habits,
  }) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('Habit'),
              ),
              const Expanded(
                child: Text('Progress'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.habits.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.habits[index].title,
                      ),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: widget.habits[index].completed ? 1 : 0,
                      ),
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

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function onToggleDarkMode;
  final String language;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.language,
    required this.onLanguageChange,
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
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.onToggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: widget.language,
                onChanged: (String? value) {
                  widget.onLanguageChange(value!);
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