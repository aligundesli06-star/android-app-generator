import 'package:flutter/material.dart';
import 'dart:async';

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

  List<Mood> _moods = [];

  void _addMood() {
    setState(() {
      _moods.add(Mood(
        DateTime.now(),
        _moods.isEmpty ? MoodType.happy : MoodType.values[_moods.last.type.index + 1],
      ));
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mood Journal'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(moods: _moods),
            ProgressScreen(moods: _moods),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onToggleDarkMode: _toggleDarkMode,
              onChangeLanguage: _changeLanguage,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
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

class Mood {
  final DateTime date;
  final MoodType type;

  Mood(this.date, this.type);
}

enum MoodType { happy, sad, angry }

class HomeScreen extends StatelessWidget {
  final List<Mood> moods;

  const HomeScreen({Key? key, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.sentiment_very_satisfied,
                    color: moods[index].type == MoodType.happy
                        ? Colors.green
                        : moods[index].type == MoodType.sad
                            ? Colors.blue
                            : Colors.red,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mood: ${moods[index].type.name}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Date: ${moods[index].date}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
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
  final List<Mood> moods;

  const ProgressScreen({Key? key, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('Happy')),
              ),
              const SizedBox(width: 16),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('Sad')),
              ),
              const SizedBox(width: 16),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('Angry')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function onToggleDarkMode;
  final Function onChangeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onToggleDarkMode,
    required this.onChangeLanguage,
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
                value: isDarkMode,
                onChanged: (bool value) {
                  onToggleDarkMode();
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
                value: language,
                onChanged: (String? value) {
                  onChangeLanguage(value);
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