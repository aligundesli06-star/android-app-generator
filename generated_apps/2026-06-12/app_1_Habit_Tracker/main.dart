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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(
        isDarkMode: _isDarkMode,
        language: _language,
        onLanguageChange: (language) {
          setState(() {
            _language = language;
          });
        },
        onDarkModeChange: (isDarkMode) {
          setState(() {
            _isDarkMode = isDarkMode;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function onLanguageChange;
  final Function onDarkModeChange;

  const MyHomePage({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onLanguageChange,
    required this.onDarkModeChange,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Habit> habits = [
    Habit('Exercise', Icons.running),
    Habit('Meditation', Icons.meditation),
    Habit('Reading', Icons.book),
  ];

  void _addHabit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddHabitPage()),
    ).then((habit) {
      if (habit != null) {
        setState(() {
          habits.add(habit);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            habits: habits,
            onAddHabit: _addHabit,
          ),
          ProgressScreen(
            habits: habits,
          ),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            onLanguageChange: (language) {
              widget.onLanguageChange(language);
            },
            onDarkModeChange: (isDarkMode) {
              widget.onDarkModeChange(isDarkMode);
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
        child: Icon(Icons.add),
      ),
    );
  }
}

class Habit {
  final String name;
  final IconData icon;

  Habit(this.name, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final Function onAddHabit;

  const HomeScreen({
    Key? key,
    required this.habits,
    required this.onAddHabit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                  SizedBox(width: 16),
                  Text(
                    habit.name,
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
  final List<Habit> habits;

  const ProgressScreen({
    Key? key,
    required this.habits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits.map((habit) {
          return Row(
            children: [
              Text(
                habit.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
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

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function onLanguageChange;
  final Function onDarkModeChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onLanguageChange,
    required this.onDarkModeChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode'),
              Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onDarkModeChange(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language'),
              Spacer(),
              DropdownButton(
                value: language,
                items: [
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
                  onLanguageChange(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({Key? key}) : super(key: key);

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  IconData _icon = Icons.running;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
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
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.running),
                  Icon(Icons.meditation),
                  Icon(Icons.book),
                ].map((icon) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _icon = icon.icon;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _icon == icon
                              ? Colors.indigo
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: icon,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      Habit(_nameController.text, _icon),
                    );
                  }
                },
                child: Text('Add Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}