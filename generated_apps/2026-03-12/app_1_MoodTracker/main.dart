import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MoodTracker',
      home: MoodTracker(),
    );
  }
}

class MoodTracker extends StatefulWidget {
  const MoodTracker({Key? key}) : super(key: key);

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  final List<Mood> _moods = [
    const Mood('Happy', Colors.yellow, Icons.smile),
    const Mood('Sad', Colors.blue, Icons.sentiment_downtrend),
    const Mood('Neutral', Colors.grey, Icons.sentiment_neutral),
  ];

  final _moodController = TextEditingController();

  void _addMood() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Mood'),
          content: TextField(
            controller: _moodController,
            decoration: const InputDecoration(hintText: 'Enter your mood'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_moodController.text.isNotEmpty) {
                  setState(() {
                    _moods.add(Mood(_moodController.text, Colors.purple, Icons.sentiment_satisfied));
                  });
                  _moodController.clear();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            Home(),
            Progress(),
            Settings(),
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addMood,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Mood {
  final String name;
  final Color color;
  final IconData icon;

  const Mood(this.name, this.color, this.icon);
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Icon(Icons.smile, size: 48),
                  Text('Happy', style: TextStyle(fontSize: 24)),
                  Text('Today', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Icon(Icons.sentiment_downtrend, size: 48),
                  Text('Sad', style: TextStyle(fontSize: 24)),
                  Text('Yesterday', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart, size: 48),
              Text('Progress', style: TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Happy: 50%'),
              SizedBox(width: 16),
              Text('Sad: 30%'),
              SizedBox(width: 16),
              Text('Neutral: 20%'),
            ],
          ),
        ],
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    (_isDarkMode)
                        ? Theme.of(context).copyWith(
                            primarySwatch: Colors.indigo,
                          )
                        : Theme.of(context).copyWith(
                            primarySwatch: Colors.indigo,
                          );
                  });
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Theme(
                        data: (_isDarkMode)
                            ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
                            : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
                        child: const MoodTracker(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value as String;
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