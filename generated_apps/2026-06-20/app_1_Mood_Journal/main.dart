import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  List<MoodItem> _moods = [];
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              moods: _moods,
              onAdd: (item) {
                setState(() {
                  _moods.add(item);
                });
              },
            ),
            ProgressScreen(moods: _moods),
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
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: const Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final _controller = TextEditingController();
                final _moodController = TextEditingController();
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'Mood Description',
                          ),
                        ),
                        TextField(
                          controller: _moodController,
                          decoration: const InputDecoration(
                            labelText: 'Mood Type',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _moods.add(MoodItem(_controller.text, _moodController.text));
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add Mood'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          tooltip: 'Add Mood',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class MoodItem {
  final String description;
  final String type;

  MoodItem(this.description, this.type);
}

class HomeScreen extends StatelessWidget {
  final List<MoodItem> moods;
  final Function(MoodItem) onAdd;

  const HomeScreen({super.key, required this.moods, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.mood),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moods[index].type,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        moods[index].description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
  final List<MoodItem> moods;

  const ProgressScreen({super.key, required this.moods});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Good',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                '${moods.where((mood) => mood.type == 'Good').length} moods',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Neutral',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                '${moods.where((mood) => mood.type == 'Neutral').length} moods',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Bad',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                '${moods.where((mood) => mood.type == 'Bad').length} moods',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const SettingsScreen({super.key, required this.onDarkModeChanged, required this.onLanguageChanged});

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
              const Text('Dark Mode'),
              const SizedBox(width: 16.0),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  widget.onDarkModeChanged(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16.0),
              DropdownButton(
                value: _language,
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                  });
                  widget.onLanguageChanged(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}