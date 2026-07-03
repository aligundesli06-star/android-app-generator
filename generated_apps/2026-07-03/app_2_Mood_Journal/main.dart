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
  List<MoodItem> _moodItems = [];
  bool _darkMode = false;
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = const Locale('en');
  }

  void _addMoodItem(MoodItem item) {
    setState(() {
      _moodItems.add(item);
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _darkMode = value;
      if (_darkMode) {
        Theme.of(context).copyWith(
          brightness: Brightness.dark,
        );
      } else {
        Theme.of(context).copyWith(
          brightness: Brightness.light,
        );
      }
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      if (language == 'en') {
        _locale = const Locale('en');
      } else if (language == 'tr') {
        _locale = const Locale('tr');
      } else if (language == 'es') {
        _locale = const Locale('es');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        brightness: _darkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mood Journal'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              moodItems: _moodItems,
              addMoodItem: _addMoodItem,
            ),
            ProgressScreen(
              moodItems: _moodItems,
            ),
            SettingsScreen(
              darkMode: _darkMode,
              locale: _locale,
              toggleDarkMode: _toggleDarkMode,
              changeLanguage: _changeLanguage,
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
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Mood',
                          ),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _addMoodItem(
                              MoodItem(
                                mood: 'Happy',
                                description: 'I am feeling happy',
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<MoodItem> moodItems;
  final void Function(MoodItem) addMoodItem;

  const HomeScreen({
    Key? key,
    required this.moodItems,
    required this.addMoodItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
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
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<MoodItem> moodItems;

  const ProgressScreen({
    Key? key,
    required this.moodItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Happy'),
            ],
          ),
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Neutral'),
            ],
          ),
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Sad'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool darkMode;
  final Locale? locale;
  final void Function(bool) toggleDarkMode;
  final void Function(String) changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.darkMode,
    required this.locale,
    required this.toggleDarkMode,
    required this.changeLanguage,
  }) : super(key: key);

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
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: widget.darkMode,
                onChanged: (value) {
                  widget.toggleDarkMode(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.locale?.languageCode,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'es',
                  ),
                ],
                onChanged: (value) {
                  widget.changeLanguage(value.toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoodItem {
  final String mood;
  final String description;

  MoodItem({
    required this.mood,
    required this.description,
  });
}