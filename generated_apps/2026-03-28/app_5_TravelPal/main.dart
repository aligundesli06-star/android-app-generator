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
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(
              onDarkModeChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onLanguageChanged: (value) {
                setState(() {
                  _language = value;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
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
            // Add new item logic
          },
          child: const Icon(Icons.add),
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
                children: const [
                  Icon(
                    Icons.location_city,
                    size: 48,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Discover New Destinations',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.map,
                    size: 48,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Plan Your Trip',
                    style: TextStyle(fontSize: 24),
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
            children: const [
              Icon(
                Icons.check_circle,
                size: 48,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Completed Tasks',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: const [
              Icon(
                Icons.timer,
                size: 48,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Upcoming Tasks',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 24),
              ),
              const Spacer(),
              Switch(
                value: _MyAppState().currentState!.widget._isDarkMode,
                onChanged: (value) {
                  onDarkModeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 24),
              ),
              const Spacer(),
              DropdownButton(
                value: _MyAppState().currentState!.widget._language,
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
                  onLanguageChanged(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}