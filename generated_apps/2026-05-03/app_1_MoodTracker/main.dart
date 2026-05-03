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
  Locale _locale = const Locale('en');

  final List<Mood> _moods = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      locale: _locale,
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
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
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
            Mood newMood = Mood(
              id: DateTime.now().millisecondsSinceEpoch,
              mood: 'Happy',
              date: DateTime.now(),
            );
            setState(() {
              _moods.add(newMood);
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Mood {
  final int id;
  final String mood;
  final DateTime date;

  Mood({required this.id, required this.mood, required this.date});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Mood> _moods = [
    Mood(
      id: 1,
      mood: 'Happy',
      date: DateTime.now(),
    ),
    Mood(
      id: 2,
      mood: 'Sad',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Mood(
      id: 3,
      mood: 'Angry',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _moods.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    _moods[index].mood == 'Happy'
                        ? Icons.sentiment_satisfied
                        : _moods[index].mood == 'Sad'
                            ? Icons.sentiment_dissatisfied
                            : Icons.sentiment_very_dissatisfied,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _moods[index].mood,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${_moods[index].date.year}-${_moods[index].date.month}-${_moods[index].date.day}',
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

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final List<Mood> _moods = [
    Mood(
      id: 1,
      mood: 'Happy',
      date: DateTime.now(),
    ),
    Mood(
      id: 2,
      mood: 'Sad',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Mood(
      id: 3,
      mood: 'Angry',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Happy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Sad',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Angry',
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  (context as Element).findAncestorStateOfType<_MyAppState>()?._isDarkMode = value;
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: _locale.languageCode,
                onChanged: (String? value) {
                  setState(() {
                    if (value == 'en') {
                      _locale = const Locale('en');
                    } else if (value == 'tr') {
                      _locale = const Locale('tr');
                    } else if (value == 'es') {
                      _locale = const Locale('es');
                    }
                  });
                  (context as Element).findAncestorStateOfType<_MyAppState>()?._locale = _locale;
                },
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}