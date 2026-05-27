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
  bool _darkMode = false;
  String _language = 'English';
  List<Mood> _moods = [];

  void _addMood() {
    setState(() {
      _moods.add(Mood(
        DateTime.now(),
        'New Mood',
        'You are feeling good!',
        Icons.sentiment_satisfied,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      theme: _darkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: [
            HomeScreen(
              moods: _moods,
            ),
            ProgressScreen(
              moods: _moods,
            ),
            SettingsScreen(
              darkMode: _darkMode,
              language: _language,
              onChangedDarkMode: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              onChangedLanguage: (value) {
                setState(() {
                  _language = value;
                });
              },
            ),
          ][_currentIndex],
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
        floatingActionButton: _currentIndex != 2
            ? FloatingActionButton(
                onPressed: _addMood,
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Mood> moods;

  const HomeScreen({Key? key, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: moods.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  moods[index].icon,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      moods[index].date.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      moods[index].name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      moods[index].description,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Mood> moods;

  const ProgressScreen({Key? key, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Happiness',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Progress',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Growth',
                    style: const TextStyle(fontSize: 16),
                  ),
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
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo[400],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Goals',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo[500],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Milestones',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo[600],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Reflection',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool darkMode;
  final String language;
  final Function(bool) onChangedDarkMode;
  final Function(String) onChangedLanguage;

  const SettingsScreen({
    Key? key,
    required this.darkMode,
    required this.language,
    required this.onChangedDarkMode,
    required this.onChangedLanguage,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Dark Mode'),
          trailing: Switch(
            value: widget.darkMode,
            onChanged: widget.onChangedDarkMode,
          ),
        ),
        ListTile(
          title: const Text('Language'),
          trailing: DropdownButton(
            value: widget.language,
            items: [
              'English',
              'Turkish',
              'Spanish',
            ].map((e) => DropdownMenuItem(
                  child: Text(e), value: e,)).toList(),
            onChanged: widget.onChangedLanguage,
          ),
        ),
      ],
    );
  }
}

class Mood {
  final DateTime date;
  final String name;
  final String description;
  final IconData icon;

  Mood(this.date, this.name, this.description, this.icon);
}