import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  List<Mood> _moods = [];
  bool _darkMode = false;
  String _language = 'English';

  @override
  void initState() {
    super.initState();
    _moods = [
      Mood('Happy', Icons.smile, 'I\'m feeling great today'),
      Mood('Sad', Icons.frown, 'I\'m feeling down today'),
    ];
  }

  void _addMood() {
    setState(() {
      _moods.add(Mood('Neutral', Icons.sentiment_satisfied, 'I\'m feeling neutral today'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      theme: _darkMode ? ThemeData.dark() : ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_moods, _addMood),
            ProgressScreen(_moods),
            SettingsScreen(_darkMode, _language, (value) {
              setState(() {
                _darkMode = value['darkMode'];
                _language = value['language'];
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addMood,
          tooltip: 'Add Mood',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class Mood {
  String name;
  IconData icon;
  String description;

  Mood(this.name, this.icon, this.description);
}

class HomeScreen extends StatelessWidget {
  final List<Mood> _moods;
  final Function _addMood;

  HomeScreen(this._moods, this._addMood);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _moods.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(_moods[index].icon, size: 32),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_moods[index].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(_moods[index].description, style: TextStyle(fontSize: 14)),
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
  final List<Mood> _moods;

  ProgressScreen(this._moods);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Happy', style: TextStyle(fontSize: 18)),
              Spacer(),
              Text('${_moods.where((mood) => mood.name == 'Happy').length}'),
            ],
          ),
          Row(
            children: [
              Text('Sad', style: TextStyle(fontSize: 18)),
              Spacer(),
              Text('${_moods.where((mood) => mood.name == 'Sad').length}'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool _darkMode;
  final String _language;
  final Function _onChange;

  SettingsScreen(this._darkMode, this._language, this._onChange);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode', style: TextStyle(fontSize: 18)),
              Spacer(),
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  _onChange({'darkMode': value, 'language': _language});
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language', style: TextStyle(fontSize: 18)),
              Spacer(),
              DropdownButton(
                value: _language,
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
                  _onChange({'darkMode': _darkMode, 'language': value});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}