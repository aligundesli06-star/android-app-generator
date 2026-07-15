import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MoodTracker();
  }
}

class MoodTracker extends StatefulWidget {
  const MoodTracker({Key? key}) : super(key: key);

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  int _currentIndex = 0;
  List<Mood> _moods = [];
  bool _isDarkMode = false;
  String _language = 'English';

  void _addMood() {
    setState(() {
      _moods.add(Mood(
        DateTime.now(),
        'Happy',
        'I\'m feeling great today!',
      ));
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
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
            const HomeScreen(),
            const ProgressScreen(),
            SettingsScreen(
              toggleDarkMode: _toggleDarkMode,
              selectLanguage: _selectLanguage,
              language: _language,
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
          onPressed: _addMood,
          tooltip: 'Add Mood',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.sentiment_very_satisfied),
              title: Text('Happy'),
              subtitle: Text('I\'m feeling great today!'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.sentiment_neutral),
              title: Text('Neutral'),
              subtitle: Text('I\'m feeling okay today'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.sentiment_very_dissatisfied),
              title: Text('Sad'),
              subtitle: Text('I\'m feeling down today'),
            ),
          ),
        ],
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
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text('Happy'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text('Neutral'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text('Sad'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text('Progress'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function toggleDarkMode;
  final Function selectLanguage;
  final String language;

  const SettingsScreen({
    Key? key,
    required this.toggleDarkMode,
    required this.selectLanguage,
    required this.language,
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
              const SizedBox(width: 16),
              Switch(
                value: context.findAncestorWidgetOfExactType<MoodTracker>()!._isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: language,
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
                  selectLanguage(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Mood {
  final DateTime date;
  final String mood;
  final String description;

  Mood(this.date, this.mood, this.description);
}