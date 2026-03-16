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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = constLocale;
  static const Locale constLocale = Locale('en');

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _moodEntries = <MoodEntry>[];

  void _addMoodEntry() async {
    final moodEntry = await showDialog(
      context: context,
      builder: (context) {
        final _moodController = TextEditingController();
        String _mood = '';

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your mood'),
              TextField(
                controller: _moodController,
                decoration: const InputDecoration(
                  labelText: 'Mood',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _mood = _moodController.text;
                  Navigator.of(context).pop(_mood);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );

    if (moodEntry != null) {
      setState(() {
        _moodEntries.add(MoodEntry(moodEntry));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodJournal'),
      ),
      body: _currentIndex == 0
          ? HomeScreen(moodEntries: _moodEntries)
          : _currentIndex == 1
              ? ProgressScreen(moodEntries: _moodEntries)
              : SettingsScreen(
                  toggleTheme: _toggleTheme,
                  changeLocale: _changeLocale,
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
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
        onPressed: _addMoodEntry,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MoodEntry {
  final String mood;

  MoodEntry(this.mood);
}

class HomeScreen extends StatelessWidget {
  final List<MoodEntry> moodEntries;

  const HomeScreen({super.key, required this.moodEntries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'How are you feeling today?',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ...moodEntries.map((entry) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied,
                      color: Colors yellow[700],
                    ),
                    const SizedBox(width: 16),
                    Text(entry.mood),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<MoodEntry> moodEntries;

  const ProgressScreen({super.key, required this.moodEntries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Your Progress',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Happy'),
                    const Text('50%'),
                    LinearProgressIndicator(
                      value: 0.5,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Sad'),
                    const Text('30%'),
                    LinearProgressIndicator(
                      value: 0.3,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Neutral'),
                    const Text('20%'),
                    LinearProgressIndicator(
                      value: 0.2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function toggleTheme;
  final Function changeLocale;

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
    required this.changeLocale,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) => toggleTheme(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                onChanged: (Locale? locale) => changeLocale(locale),
                value: Locale('en'),
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: Locale('es'),
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