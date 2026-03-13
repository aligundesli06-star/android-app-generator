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
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodPal',
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
            HomeScreen(() {
              setState(() {
                _currentIndex = 1;
              });
            }, () {
              setState(() {
                _currentIndex = 2;
              });
            }),
            ProgressScreen(() {
              setState(() {
                _currentIndex = 0;
              });
            }, () {
              setState(() {
                _currentIndex = 2;
              });
            }),
            SettingsScreen(() {
              setState(() {
                _currentIndex = 0;
              });
            }, () {
              setState(() {
                _currentIndex = 1;
              });
            }, _isDarkMode, (value) {
              setState(() {
                _isDarkMode = value;
              });
            }, _language, (value) {
              setState(() {
                _language = value;
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
          onPressed: () {
            // add new item
          },
          tooltip: 'Add new item',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toProgress;
  final VoidCallback toSettings;

  HomeScreen(this.toProgress, this.toSettings);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.restaurant),
                      SizedBox(width: 8),
                      Text('Recipe 1'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('This is a recipe description'),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.restaurant),
                      SizedBox(width: 8),
                      Text('Recipe 2'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('This is another recipe description'),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: toProgress,
            child: Text('View Progress'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: toSettings,
            child: Text('View Settings'),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final VoidCallback toHome;
  final VoidCallback toSettings;

  ProgressScreen(this.toHome, this.toSettings);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart),
              SizedBox(width: 8),
              Text('Progress'),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  Text('Step 1'),
                  SizedBox(width: 8),
                  Icon(Icons.check),
                ],
              ),
              Row(
                children: [
                  Text('Step 2'),
                  SizedBox(width: 8),
                  Icon(Icons.check),
                ],
              ),
              Row(
                children: [
                  Text('Step 3'),
                  SizedBox(width: 8),
                  Icon(Icons.close),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: toHome,
            child: Text('Back to Home'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: toSettings,
            child: Text('View Settings'),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback toHome;
  final VoidCallback toProgress;
  final bool isDarkMode;
  final Function onDarkModeChanged;
  final String language;
  final Function onLanguageChanged;

  SettingsScreen(this.toHome, this.toProgress, this.isDarkMode, this.onDarkModeChanged, this.language, this.onLanguageChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 8),
              Text('Settings'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Dark Mode:'),
              SizedBox(width: 8),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onDarkModeChanged(value);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Language:'),
              SizedBox(width: 8),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  onLanguageChanged(value);
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
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: toHome,
            child: Text('Back to Home'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: toProgress,
            child: Text('Back to Progress'),
          ),
        ],
      ),
    );
  }
}