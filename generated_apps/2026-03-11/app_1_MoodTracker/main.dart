import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatefulWidget {
  const MoodTrackerApp({super.key});

  @override
  State<MoodTrackerApp> createState() => _MoodTrackerAppState();
}

class _MoodTrackerAppState extends State<MoodTrackerApp> {
  int _currentIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void _changeThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  List<MoodItem> _moodItems = [
    const MoodItem(mood: 'Happy', date: '2024-01-01', description: 'Today was great'),
    const MoodItem(mood: 'Sad', date: '2024-01-02', description: 'Today was not great'),
  ];

  void _addMoodItem() {
    setState(() {
      _moodItems.add(const MoodItem(
        mood: 'New Mood',
        date: 'Today',
        description: 'New mood',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      locale: _locale,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              moodItems: _moodItems,
            ),
            ProgressScreen(moodItems: _moodItems),
            SettingsScreen(
              changeThemeMode: _changeThemeMode,
              changeLocale: _changeLocale,
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
          onPressed: _addMoodItem,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<MoodItem> moodItems;

  const HomeScreen({super.key, required this.moodItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moodItems.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        moodItems[index].mood,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Text(moodItems[index].date),
                    ],
                  ),
                  Text(moodItems[index].description),
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
  final List<MoodItem> moodItems;

  const ProgressScreen({super.key, required this.moodItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.sunny),
              Text('Happy'),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.cloud),
              Text('Sad'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.bar_chart),
              Text('Progress'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final void Function(ThemeMode) changeThemeMode;
  final void Function(Locale) changeLocale;

  const SettingsScreen({
    super.key,
    required this.changeThemeMode,
    required this.changeLocale,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Theme:'),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeThemeMode(ThemeMode.light),
                child: const Text('Light'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeThemeMode(ThemeMode.dark),
                child: const Text('Dark'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeLocale(const Locale('en')),
                child: const Text('English'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeLocale(const Locale('tr')),
                child: const Text('Turkish'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeLocale(const Locale('es')),
                child: const Text('Spanish'),
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
  final String date;
  final String description;

  const MoodItem({
    required this.mood,
    required this.date,
    required this.description,
  });
}