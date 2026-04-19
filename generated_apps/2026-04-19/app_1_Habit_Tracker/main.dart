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

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String newLanguage) {
    setState(() {
      _language = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
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
        body: _currentIndex == 0
            ? HomeScreen()
            : _currentIndex == 1
                ? ProgressScreen()
                : SettingsScreen(
                    toggleDarkMode: _toggleDarkMode,
                    changeLanguage: _changeLanguage,
                    isDarkMode: _isDarkMode,
                    language: _language,
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
            // Add new habit
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
                  Icon(
                    Icons.directions_run,
                    size: 32,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Running',
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
              child: Row(
                children: [
                  Icon(
                    Icons.pool,
                    size: 32,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Swimming',
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
              child: Row(
                children: [
                  Icon(
                    Icons.local_grocery_store,
                    size: 32,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Healthy Eating',
                    style: TextStyle(fontSize: 18),
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

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Running',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '50%',
                    style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    'Swimming',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '30%',
                    style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Healthy Eating',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '70%',
                    style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
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

class SettingsScreen extends StatelessWidget {
  final Function toggleDarkMode;
  final Function changeLanguage;
  final bool isDarkMode;
  final String language;

  SettingsScreen({
    required this.toggleDarkMode,
    required this.changeLanguage,
    required this.isDarkMode,
    required this.language,
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
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  changeLanguage(value);
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
        ],
      ),
    );
  }
}