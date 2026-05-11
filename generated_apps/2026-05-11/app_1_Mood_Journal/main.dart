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
  final List<Mood> _moods = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: HomeScreen(
        currentIndex: _currentIndex,
        isDarkMode: _isDarkMode,
        language: _language,
        moods: _moods,
        onChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onDarkModeChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
        onLanguageChanged: (String value) {
          setState(() {
            _language = value;
          });
        },
        onAddMood: (Mood mood) {
          setState(() {
            _moods.add(mood);
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final int currentIndex;
  final bool isDarkMode;
  final String language;
  final List<Mood> moods;
  final Function(int) onChanged;
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;
  final Function(Mood) onAddMood;

  const HomeScreen({
    Key? key,
    required this.currentIndex,
    required this.isDarkMode,
    required this.language,
    required this.moods,
    required this.onChanged,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
    required this.onAddMood,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeTab(
            moods: widget.moods,
            onAddMood: widget.onAddMood,
          ),
          ProgressTab(
            moods: widget.moods,
          ),
          SettingsTab(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            onDarkModeChanged: widget.onDarkModeChanged,
            onLanguageChanged: widget.onLanguageChanged,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onChanged,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          const BottomNavigationBarItem(
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
                      const Text('Add Mood'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                widget.onAddMood(
                                  const Mood(
                                    mood: 'Happy',
                                    date: DateTime.now(),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Happy'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                widget.onAddMood(
                                  const Mood(
                                    mood: 'Sad',
                                    date: DateTime.now(),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Sad'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                widget.onAddMood(
                                  const Mood(
                                    mood: 'Angry',
                                    date: DateTime.now(),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Angry'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                widget.onAddMood(
                                  const Mood(
                                    mood: 'Neutral',
                                    date: DateTime.now(),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Neutral'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final List<Mood> moods;
  final Function(Mood) onAddMood;

  const HomeTab({
    Key? key,
    required this.moods,
    required this.onAddMood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: moods.map((mood) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    getMoodIcon(mood.mood),
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    mood.mood,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${mood.date.month}/${mood.date.day}/${mood.date.year}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData getMoodIcon(String mood) {
    switch (mood) {
      case 'Happy':
        return Icons.smile;
      case 'Sad':
        return Icons.sadness;
      case 'Angry':
        return Icons.anger;
      default:
        return Icons.neutral;
    }
  }
}

class ProgressTab extends StatelessWidget {
  final List<Mood> moods;

  const ProgressTab({
    Key? key,
    required this.moods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.smile,
                          size: 24,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Happy',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${moods.where((mood) => mood.mood == 'Happy').length}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.sadness,
                          size: 24,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sad',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${moods.where((mood) => mood.mood == 'Sad').length}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.anger,
                          size