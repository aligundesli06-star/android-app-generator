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
  bool _darkMode = false;
  String _language = 'English';

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Habits',
      theme: _darkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: MyHomePage(
        darkMode: _darkMode,
        language: _language,
        toggleDarkMode: _toggleDarkMode,
        changeLanguage: _changeLanguage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool darkMode;
  final String language;
  final Function toggleDarkMode;
  final Function changeLanguage;

  MyHomePage({
    required this.darkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<String> habits = ['Exercise', 'Meditation', 'Reading'];
  List<String> progress = ['50%', '75%', '25%'];

  void _addHabit() {
    setState(() {
      habits.add('New Habit');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(habits: habits),
          ProgressScreen(progress: progress),
          SettingsScreen(
            darkMode: widget.darkMode,
            language: widget.language,
            toggleDarkMode: widget.toggleDarkMode,
            changeLanguage: widget.changeLanguage,
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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

class HomeScreen extends StatelessWidget {
  final List<String> habits;

  HomeScreen({required this.habits});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.check_circle),
                  SizedBox(width: 16),
                  Text(
                    habits[index],
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
  final List<String> progress;

  ProgressScreen({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Exercise: ${progress[0]}'),
              SizedBox(width: 16),
              Text('Meditation: ${progress[1]}'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Reading: ${progress[2]}'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool darkMode;
  final String language;
  final Function toggleDarkMode;
  final Function changeLanguage;

  SettingsScreen({
    required this.darkMode,
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
              Text('Dark Mode'),
              SizedBox(width: 16),
              Switch(
                value: darkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Language'),
              SizedBox(width: 16),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  changeLanguage(value);
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
            ],
          ),
        ],
      ),
    );
  }
}