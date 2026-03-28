import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodJournal',
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

  final List<Mood> _moods = [
    Mood('Happy', 'I am feeling happy today', DateTime.now(), Colors.green),
    Mood('Sad', 'I am feeling sad today', DateTime.now(), Colors.red),
    Mood('Neutral', 'I am feeling neutral today', DateTime.now(), Colors.blue),
  ];

  void _addMood() {
    setState(() {
      _moods.add(Mood('New Mood', 'I am feeling new mood today', DateTime.now(), Colors.purple));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(_moods, _addMood),
          ProgressScreen(_moods),
          SettingsScreen(_isDarkMode, _language, (value) {
            setState(() {
              _isDarkMode = value;
              ThemeMode themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
              // ignore: unused_local_variable
              ThemeData themeData = Theme.of(context).copyWith();
            });
          }, (language) {
            setState(() {
              _language = language;
            });
          }),
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
        tooltip: 'Add New Mood',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Mood> _moods;
  final Function _addMood;

  const HomeScreen(this._moods, this._addMood, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _moods.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.emotions,
                    color: _moods[index].color,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _moods[index].title,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          _moods[index].description,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          _moods[index].dateTime.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              const Text(
                'Progress',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: _moods.map((mood) {
              return Row(
                children: [
                  Text(
                    mood.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: mood.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool _isDarkMode;
  final String _language;
  final Function _toggleDarkMode;
  final Function _changeLanguage;

  const SettingsScreen(this._isDarkMode, this._language, this._toggleDarkMode, this._changeLanguage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 16),
              const Text(
                'Settings',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  _toggleDarkMode(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  _changeLanguage(value);
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
  final String title;
  final String description;
  final DateTime dateTime;
  final Color color;

  Mood(this.title, this.description, this.dateTime, this.color);
}