import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';
  List<Habit> _habits = [];
  final _habitsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              habits: _habits,
              addHabit: (habit) {
                setState(() {
                  _habits.add(habit);
                });
              },
            ),
            ProgressScreen(habits: _habits),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              toggleDarkMode: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              changeLanguage: (language) {
                setState(() {
                  _language = language;
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: TextField(
                    controller: _habitsController,
                    decoration: InputDecoration(labelText: 'Habit Name'),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _habits.add(Habit(name: _habitsController.text));
                          _habitsController.clear();
                        });
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final Function addHabit;

  const HomeScreen({super.key, required this.habits, required this.addHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    habits[index].icon,
                    size: 40,
                  ),
                  Text(
                    habits[index].name,
                    style: TextStyle(fontSize: 18),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits.map((habit) {
          return Row(
            children: [
              Icon(habit.icon),
              Text(habit.name),
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.5,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function toggleDarkMode;
  final Function changeLanguage;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  });

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
              Text('Dark Mode'),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.toggleDarkMode(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language'),
              DropdownButton(
                value: widget.language,
                onChanged: (language) {
                  widget.changeLanguage(language);
                },
                items: [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Habit {
  final String name;
  final IconData icon;

  Habit({required this.name, this.icon = Icons.question_mark});
}