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
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        body:IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(() {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            }, () {
              setState(() {
                if (_language == 'English') {
                  _language = 'Turkish';
                } else if (_language == 'Turkish') {
                  _language = 'Spanish';
                } else {
                  _language = 'English';
                }
              });
            }, _language),
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
          onPressed: () {
            // Add new item functionality
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_satisfied, size: 40),
                  SizedBox(width: 16),
                  Text('Good', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_neutral, size: 40),
                  SizedBox(width: 16),
                  Text('Neutral', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_dissatisfied, size: 40),
                  SizedBox(width: 16),
                  Text('Bad', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text('Happy', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('70%', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text('Neutral', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('20%', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text('Sad', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('10%', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text('Week', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('10', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text('Month', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('30', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text('Year', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('365', style: TextStyle(fontSize: 24)),
                    ],
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

class SettingsScreen extends StatefulWidget {
  final Function darkModeToggle;
  final Function languageToggle;
  final String language;

  const SettingsScreen(this.darkModeToggle, this.languageToggle, this.language, {Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text('Dark Mode', style: TextStyle(fontSize: 18)),
                  const Spacer(),
                  Switch(
                    value: true,
                    onChanged: (value) {
                      widget.darkModeToggle();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text('Language: ${widget.language}', style: const TextStyle(fontSize: 18)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      widget.languageToggle();
                    },
                    child: const Text('Change'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}