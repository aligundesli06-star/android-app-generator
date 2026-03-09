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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
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
              MaterialPageRoute(builder: (context) => AddHabitScreen()),
            ).then((habit) {
              if (habit != null) {
                setState(() {
                  _habits.add(habit);
                });
              }
            });
          },
          tooltip: 'Add Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _MyAppState().habits.length,
        itemBuilder: (context, index) {
          return HabitCard(habit: _MyAppState().habits[index]);
        },
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              children: [
                Icon(habit.icon),
                Text(habit.name),
                Text(habit.description),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          Row(
            children: [
              Text('Habit'),
              Spacer(),
              Text('Progress'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                value: _MyAppState().isDarkMode,
                onChanged: (value) {
                  _MyAppState().setState(() {
                    _MyAppState().isDarkMode = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: _MyAppState().language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  _MyAppState().setState(() {
                    _MyAppState().language = value as String;
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
  final _descriptionController = TextEditingController();
  final _iconController = TextEditingController();

  Habit? _habit;

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
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter habit name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Habit Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter habit description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _iconController,
                decoration: const InputDecoration(
                  labelText: 'Habit Icon',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter habit icon';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _habit = Habit(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      icon: _iconController.text,
                    );
                    Navigator.pop(context, _habit);
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

class Habit {
  final String name;
  final String description;
  final String icon;

  Habit({required this.name, required this.description, required this.icon});
}

class _MyAppState {
  bool _isDarkMode = false;
  String _language = 'English';
  List<Habit> _habits = [];

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  List<Habit> get habits => _habits;

  void setState(void Function() callback) {
    callback();
  }
}