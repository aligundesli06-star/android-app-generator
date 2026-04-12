import 'dart:async' show Timer;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';
  List<Mood> _moods = [
    Mood('Happy', Colors.yellow),
    Mood('Sad', Colors.blue),
    Mood('Angry', Colors.red),
  ];

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

  void _addMood() {
    setState(() {
      _moods.add(Mood('New Mood', Colors.green));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(_moods, _addMood),
          ProgressScreen(_moods),
          SettingsScreen(_toggleDarkMode, _changeLanguage, _isDarkMode, _language),
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
        onPressed: _addMood,
        tooltip: 'Add Mood',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Mood> _moods;
  final VoidCallback _addMood;

  const HomeScreen(this._moods, this._addMood, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _moods.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.face,
                    color: _moods[index].color,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    _moods[index].name,
                    style: const TextStyle(fontSize: 18),
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
  final List<Mood> _moods;

  const ProgressScreen(this._moods, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                size: 40,
              ),
              const SizedBox(width: 16),
              const Text(
                'Mood Progress',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._moods.map((mood) => Text(mood.name)).toList(),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback _toggleDarkMode;
  final VoidCallback _changeLanguage;
  final bool _isDarkMode;
  final String _language;

  const SettingsScreen(this._toggleDarkMode, this._changeLanguage, this._isDarkMode, this._language, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.toggle_on,
                size: 24,
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: _toggleDarkMode,
                child: Text(
                  _isDarkMode ? 'Light Mode' : 'Dark Mode',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.language,
                size: 24,
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                onChanged: (value) {
                  _changeLanguage();
                  if (value == 'English') {
                    // No action needed for english
                  } else if (value == 'Turkish') {
                    // Add Turkish translation
                  } else if (value == 'Spanish') {
                    // Add Spanish translation
                  }
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

class Mood {
  final String name;
  final Color color;

  Mood(this.name, this.color);
}