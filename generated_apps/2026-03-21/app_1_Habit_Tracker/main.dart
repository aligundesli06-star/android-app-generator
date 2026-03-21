import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';
  List<Habit> _habits = [];
  final _habitController = TextEditingController();
  Timer? _timer;

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

  void _addHabit() {
    if (_habitController.text.isNotEmpty) {
      setState(() {
        _habits.add(Habit(_habitController.text, false));
        _habitController.clear();
      });
    }
  }

  void _updateHabit(Habit habit) {
    setState(() {
      habit.completed = !habit.completed;
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
              brightness: Brightness.light,
            ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Habit Tracker'),
        ),
        body: _currentIndex == 0
            ? HomeScreen(
                habits: _habits,
                updateHabit: _updateHabit,
                addHabit: _addHabit,
                habitController: _habitController,
              )
            : _currentIndex == 1
                ? ProgressScreen(habits: _habits)
                : SettingsScreen(
                    toggleDarkMode: _toggleDarkMode,
                    changeLanguage: _changeLanguage,
                    isDarkMode: _isDarkMode,
                    language: _language,
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
      ),
    );
  }
}

class Habit {
  String title;
  bool completed;

  Habit(this.title, this.completed);
}

class HomeScreen extends StatefulWidget {
  final List<Habit> habits;
  final void Function(Habit) updateHabit;
  final void Function() addHabit;
  final TextEditingController habitController;

  HomeScreen({
    required this.habits,
    required this.updateHabit,
    required this.addHabit,
    required this.habitController,
  });

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: widget.habitController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              suffixIcon: IconButton(
                onPressed: widget.addHabit,
                icon: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.habits.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(widget.habits[index].title),
                    trailing: Checkbox(
                      value: widget.habits[index].completed,
                      onChanged: (value) {
                        widget.updateHabit(widget.habits[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Habit> habits;

  ProgressScreen({required this.habits});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Completed: ${habits.where((habit) => habit.completed).length}/${habits.length}',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(habits[index].title),
                  trailing: Icon(
                    habits[index].completed ? Icons.check : Icons.close,
                  ),
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
  final void Function() toggleDarkMode;
  final void Function(String) changeLanguage;
  final bool isDarkMode;
  final String language;

  SettingsScreen({
    required this.toggleDarkMode,
    required this.changeLanguage,
    required this.isDarkMode,
    required this.language,
  });

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: widget.isDarkMode,
              onChanged: (value) {
                widget.toggleDarkMode();
              },
            ),
          ),
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton(
              value: widget.language,
              onChanged: (value) {
                widget.changeLanguage(value.toString());
              },
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
            ),
          ),
        ],
      ),
    );
  }
}