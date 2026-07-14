import 'dart:async';
import 'dart:io';
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

  final List<String> _languages = ['English', 'Turkish', 'Spanish'];
  final List<String> _moodEntries = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
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
            setState(() {
              _moodEntries.add(DateTime.now().toString());
            });
          },
          tooltip: 'Add new entry',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  const Text(
                    'How are you feeling today?',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(Icons.sentiment_very_satisfied),
                      SizedBox(width: 16),
                      Icon(Icons.sentiment_satisfied),
                      SizedBox(width: 16),
                      Icon(Icons.sentiment_neutral),
                      SizedBox(width: 16),
                      Icon(Icons.sentiment_dissatisfied),
                      SizedBox(width: 16),
                      Icon(Icons.sentiment_very_dissatisfied),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Write, draw or record your thoughts',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(Icons.edit),
                      SizedBox(width: 16),
                      Icon(Icons.image),
                      SizedBox(width: 16),
                      Icon(Icons.mic),
                    ],
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
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Happy'),
              SizedBox(width: 16),
              Icon(Icons.sentiment_very_satisfied),
              Text(' 50%'),
            ],
          ),
          Row(
            children: const [
              Text('Neutral'),
              SizedBox(width: 16),
              Icon(Icons.sentiment_neutral),
              Text(' 30%'),
            ],
          ),
          Row(
            children: const [
              Text('Sad'),
              SizedBox(width: 16),
              Icon(Icons.sentiment_dissatisfied),
              Text(' 20%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    MyApp.of(context)?.setState(() {
                      MyApp._isDarkMode = value;
                    });
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                onChanged: (String? value) {
                  setState(() {
                    _language = value!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'Turkish',
                    child: Text('Turkish'),
                  ),
                  DropdownMenuItem(
                    value: 'Spanish',
                    child: Text('Spanish'),
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