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
  String _selectedLanguage = 'English';
  List<Habit> _habits = [];

  @override
  void initState() {
    super.initState();
    _habits.add(Habit('Read a book', 'Read for 30 minutes', Icons.book));
    _habits.add(Habit('Exercise', 'Exercise for 60 minutes', Icons.directions_run));
    _habits.add(Habit('Meditate', 'Meditate for 15 minutes', Icons.accessibility));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Builder',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habits: _habits),
            ProgressScreen(habits: _habits),
            SettingsScreen(
              onThemeChange: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onLanguageChange: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
              isDarkMode: _isDarkMode,
              selectedLanguage: _selectedLanguage,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                String _habitName = '';
                String _habitDescription = '';
                Icon _habitIcon = const Icon(Icons.directions_run);

                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Habit Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _habitName = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Habit Description',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _habitDescription = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.directions_run),
                            onPressed: () {
                              _habitIcon = const Icon(Icons.directions_run);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.book),
                            onPressed: () {
                              _habitIcon = const Icon(Icons.book);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.accessibility),
                            onPressed: () {
                              _habitIcon = const Icon(Icons.accessibility);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        setState(() {
                          _habits.add(Habit(_habitName, _habitDescription, _habitIcon.icon));
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String name;
  final String description;
  final IconData icon;

  Habit(this.name, this.description, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: habits.map((habit) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(habit.icon),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(habit.description),
                    ],
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
              Text(habit.name),
              const Spacer(),
              Text('30%'),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onThemeChange;
  final Function(String) onLanguageChange;
  final bool isDarkMode;
  final String selectedLanguage;

  const SettingsScreen({
    Key? key,
    required this.onThemeChange,
    required this.onLanguageChange,
    required this.isDarkMode,
    required this.selectedLanguage,
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
                onChanged: onThemeChange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: selectedLanguage,
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
                onChanged: onLanguageChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}