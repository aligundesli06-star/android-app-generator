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
  bool _isDarkMode = false;

  final List<Habit> _habits = [
    const Habit(name: 'Exercise', icon: Icons.directions_run),
    const Habit(name: 'Meditation', icon: Icons.self_improvement),
    const Habit(name: 'Reading', icon: Icons.book),
  ];

  void _addHabit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddHabitScreen()),
    ).then((newHabit) {
      if (newHabit != null) {
        setState(() {
          _habits.add(newHabit);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitHub',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              habits: _habits,
              addHabit: _addHabit,
            ),
            ProgressScreen(
              habits: _habits,
            ),
            SettingsScreen(
              language: _language,
              isDarkMode: _isDarkMode,
              onLanguageChanged: (language) {
                setState(() {
                  _language = language;
                });
              },
              onDarkModeChanged: (isDarkMode) {
                setState(() {
                  _isDarkMode = isDarkMode;
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
      ),
    );
  }
}

class Habit {
  final String name;
  final IconData icon;

  const Habit({required this.name, required this.icon});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final Function addHabit;

  const HomeScreen({Key? key, required this.habits, required this.addHabit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
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
                  Icon(habits[index].icon),
                  const SizedBox(width: 16),
                  Text(
                    habits[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
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
              Text(
                habit.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              const LinearProgressIndicator(
                value: 0.5,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final String language;
  final bool isDarkMode;
  final Function(String) onLanguageChanged;
  final Function(bool) onDarkModeChanged;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.isDarkMode,
    required this.onLanguageChanged,
    required this.onDarkModeChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = '';
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _language = widget.language;
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _language,
                onChanged: (language) {
                  setState(() {
                    _language = language!;
                    widget.onLanguageChanged(language);
                  });
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
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Checkbox(
                value: _isDarkMode,
                onChanged: (isDarkMode) {
                  setState(() {
                    _isDarkMode = isDarkMode!;
                    widget.onDarkModeChanged(isDarkMode);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({Key? key}) : super(key: key);

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  IconData _icon = Icons.directions_run;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Habit Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.directions_run),
                    onPressed: () {
                      setState(() {
                        _icon = Icons.directions_run;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.self_improvement),
                    onPressed: () {
                      setState(() {
                        _icon = Icons.self_improvement;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.book),
                    onPressed: () {
                      setState(() {
                        _icon = Icons.book;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      Habit(
                        name: _nameController.text,
                        icon: _icon,
                      ),
                    );
                  }
                },
                child: const Text('Add Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}