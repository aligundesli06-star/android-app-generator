import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
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
  String _language = 'English';
  bool _isDarkMode = false;
  List<Habit> _habits = [
    Habit('Exercise', Icons.directions_run, true),
    Habit('Meditation', Icons.self_improvement, false),
    Habit('Reading', Icons.book, true),
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      if (_isDarkMode) {
        ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_habits),
            ProgressScreen(_habits),
            SettingsScreen(_language, _toggleDarkMode, (value) {
              setState(() {
                _language = value;
              });
            }),
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
            showDialog(
              context: context,
              builder: (context) {
                final _controller = TextEditingController();
                return AlertDialog(
                  title: const Text('Add New Habit'),
                  content: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Habit name'),
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
                          _habits.add(
                            Habit(
                              _controller.text,
                              Icons.directions_run,
                              false,
                            ),
                          );
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          tooltip: 'Add new habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String name;
  final IconData icon;
  bool completed;

  Habit(this.name, this.icon, this.completed);
}

class HomeScreen extends StatelessWidget {
  final List<Habit> _habits;

  const HomeScreen(this._habits, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    _habits[index].icon,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    _habits[index].name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Checkbox(
                    value: _habits[index].completed,
                    onChanged: (value) {
                      // Update habit status
                    },
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
  final List<Habit> _habits;

  const ProgressScreen(this._habits, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _habits.map((habit) {
          return Row(
            children: [
              Text(
                habit.name,
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Icon(
                habit.completed ? Icons.check : Icons.close,
                color: habit.completed ? Colors.green : Colors.red,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String _language;
  final void Function() _toggleDarkMode;
  final void Function(String) _onLanguageChange;

  const SettingsScreen(
    this._language,
    this._toggleDarkMode,
    this._onLanguageChange, {
    super.key,
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
                value: _isDarkMode(context),
                onChanged: (value) {
                  _toggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: _language,
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
                onChanged: (value) {
                  _onLanguageChange(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}