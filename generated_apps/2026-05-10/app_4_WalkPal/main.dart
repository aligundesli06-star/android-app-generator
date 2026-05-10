import 'dart:async';
import 'dart:math';

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
  int _stepCount = 0;
  int _challengeProgress = 0;

  void _updateStepCount() {
    setState(() {
      _stepCount = Random().nextInt(10000);
    });
  }

  void _updateChallengeProgress() {
    setState(() {
      _challengeProgress = Random().nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalkPal',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              stepCount: _stepCount,
              updateStepCount: _updateStepCount,
            ),
            ProgressScreen(
              stepCount: _stepCount,
              challengeProgress: _challengeProgress,
              updateChallengeProgress: _updateChallengeProgress,
            ),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              updateDarkMode: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              updateLanguage: (value) {
                setState(() {
                  _language = value;
                });
              },
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
          onPressed: () {
            _updateStepCount();
            _updateChallengeProgress();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int stepCount;
  final Function updateStepCount;

  HomeScreen({required this.stepCount, required this.updateStepCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.directions_walk),
                  SizedBox(width: 16),
                  Text(
                    'Today\'s Step Count: $stepCount',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Stay active and healthy by taking regular walks. Aim for at least 10,000 steps per day.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final int stepCount;
  final int challengeProgress;
  final Function updateChallengeProgress;

  ProgressScreen({
    required this.stepCount,
    required this.challengeProgress,
    required this.updateChallengeProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Step Count: $stepCount',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text(
                'Challenge Progress: $challengeProgress%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: challengeProgress / 100,
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function updateDarkMode;
  final Function updateLanguage;

  SettingsScreen({
    required this.isDarkMode,
    required this.language,
    required this.updateDarkMode,
    required this.updateLanguage,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
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
              Text('Dark Mode: '),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.updateDarkMode(value);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Language: '),
              SizedBox(width: 16),
              DropdownButton(
                value: widget.language,
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
                  widget.updateLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}