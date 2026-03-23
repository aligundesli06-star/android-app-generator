import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
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
  String _language = 'English';
  ThemeMode _themeMode = ThemeMode.light;
  List<String> _moods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            onAddMood: (mood) {
              setState(() {
                _moods.add(mood);
              });
            },
            moods: _moods,
          ),
          ProgressScreen(moods: _moods),
          SettingsScreen(
            onLanguageChange: (language) {
              setState(() {
                _language = language;
              });
            },
            onThemeModeChange: (themeMode) {
              setState(() {
                _themeMode = themeMode;
              });
              Timer(const Duration(milliseconds: 500), () {
                setState(() {});
              });
            },
            language: _language,
            themeMode: _themeMode,
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Mood'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Mood',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _moods.add('New Mood');
                        });
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        tooltip: 'Add Mood',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function onAddMood;
  final List<String> moods;

  const HomeScreen({Key? key, required this.onAddMood, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_very_satisfied),
                  SizedBox(width: 16),
                  Text('Happy'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_neutral),
                  SizedBox(width: 16),
                  Text('Neutral'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_very_dissatisfied),
                  SizedBox(width: 16),
                  Text('Sad'),
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () {
              onAddMood('New Mood');
            },
            child: const Text('Add Mood'),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<String> moods;

  const ProgressScreen({Key? key, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.sentiment_very_satisfied),
              const SizedBox(width: 16),
              Text(
                'Happy: ${moods.where((mood) => mood == 'Happy').length}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.sentiment_neutral),
              const SizedBox(width: 16),
              Text(
                'Neutral: ${moods.where((mood) => mood == 'Neutral').length}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.sentiment_very_dissatisfied),
              const SizedBox(width: 16),
              Text(
                'Sad: ${moods.where((mood) => mood == 'Sad').length}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function onLanguageChange;
  final Function onThemeModeChange;
  final String language;
  final ThemeMode themeMode;

  const SettingsScreen({
    Key? key,
    required this.onLanguageChange,
    required this.onThemeModeChange,
    required this.language,
    required this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  onLanguageChange(value);
                },
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.brightness_4),
              const SizedBox(width: 16),
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  if (value) {
                    onThemeModeChange(ThemeMode.dark);
                  } else {
                    onThemeModeChange(ThemeMode.light);
                  }
                },
              ),
              const Text('Dark Mode'),
            ],
          ),
        ],
      ),
    );
  }
}