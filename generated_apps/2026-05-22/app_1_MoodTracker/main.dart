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
  ThemeMode _themeMode = ThemeMode.light;
  Locale? _locale;
  List<Mood> _moods = [];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      locale: _locale,
      home: const MyHomePage(),
      routes: {
        '/home': (context) => MyHomePage(
              moods: _moods,
              addMood: (mood) {
                setState(() {
                  _moods.add(mood);
                });
              },
            ),
        '/progress': (context) => ProgressPage(moods: _moods),
        '/settings': (context) => SettingsPage(
              themeMode: _themeMode,
              locale: _locale,
              changeTheme: (mode) {
                setState(() {
                  _themeMode = mode;
                });
              },
              changeLocale: (locale) {
                setState(() {
                  _locale = locale;
                });
              },
            ),
      ),
      builder: (context, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              _currentIndex = index;
              if (index == 0) {
                Navigator.of(context).pushNamed('/home');
              } else if (index == 1) {
                Navigator.of(context).pushNamed('/progress');
              } else {
                Navigator.of(context).pushNamed('/settings');
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart), label: 'Progress'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddMoodPage(
                    addMood: (mood) {
                      setState(() {
                        _moods.add(mood);
                      });
                    },
                  ),
                ),
              );
            },
            tooltip: 'Add Mood',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Mood> moods;
  final Function addMood;

  const MyHomePage({Key? key, required this.moods, required this.addMood}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodTracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.moods.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      getMoodIcon(widget.moods[index].mood),
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.moods[index].mood,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          widget.moods[index].date.toString(),
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
      ),
    );
  }

  IconData getMoodIcon(String mood) {
    switch (mood) {
      case 'Happy':
        return Icons.sentiment_satisfied;
      case 'Sad':
        return Icons.sentiment_very_dissatisfied;
      case 'Angry':
        return Icons.sentiment_very_dissatisfied;
      case 'Fearful':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
}

class ProgressPage extends StatefulWidget {
  final List<Mood> moods;

  const ProgressPage({Key? key, required this.moods}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Mood: '),
                Text(
                  getDominantMood(widget.moods),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Mood Count: '),
                Text(
                  widget.moods.length.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getDominantMood(List<Mood> moods) {
    Map<String, int> moodCounts = {};
    for (var mood in moods) {
      moodCounts[mood.mood] = (moodCounts[mood.mood] ?? 0) + 1;
    }
    String dominantMood = '';
    int maxCount = 0;
    for (var entry in moodCounts.entries) {
      if (entry.value > maxCount) {
        maxCount = entry.value;
        dominantMood = entry.key;
      }
    }
    return dominantMood;
  }
}

class SettingsPage extends StatefulWidget {
  final ThemeMode themeMode;
  final Locale? locale;
  final Function changeTheme;
  final Function changeLocale;

  const SettingsPage({
    Key? key,
    required this.themeMode,
    required this.locale,
    required this.changeTheme,
    required this.changeLocale,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode: '),
                Switch(
                  value: widget.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    widget.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language: '),
                DropdownButton<Locale>(
                  value: widget.locale,
                  onChanged: (value) {
                    widget.changeLocale(value);
                  },
                  items: [
                    const DropdownMenuItem(
                      child: Text('English'),
                      value: Locale('en'),
                    ),
                    const DropdownMenuItem(
                      child: Text('Turkish'),
                      value: Locale('tr'),
                    ),
                    const DropdownMenuItem(
                      child: Text('Spanish'),
                      value: Locale('es'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddMoodPage extends StatefulWidget {
  final Function addMood;

  const AddMoodPage({Key? key, required this.addMood}) : super(key: key);

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  String _mood = '';
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mood'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              value: _mood,
              onChanged: (value) {
                setState(() {
                  _mood = value as String;
                });
              },
              items: [
                const DropdownMenuItem(
                  child: Text('Happy'),
                  value: 'Happy',
                ),
                const DropdownMenuItem(
                  child: Text('Sad'),
                  value: 'Sad',
                ),
                const DropdownMenuItem(
                  child: Text('Angry'),
                  value: 'Angry',
                ),
                const DropdownMenuItem(
                  child: