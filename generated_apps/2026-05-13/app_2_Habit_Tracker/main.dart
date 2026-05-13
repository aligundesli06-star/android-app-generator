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

  final List<_Habit> _habits = [
    _Habit('Morning Exercise', 'Run for 30 minutes', Icons.directions_run),
    _Habit('Reading', 'Read for 1 hour', Icons.book),
    _Habit('Meditation', 'Meditate for 30 minutes', Icons.accessibility_new),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              habits: _habits,
              addHabit: () {
                _habits.add(_Habit('', '', Icons.directions_run));
                setState(() {});
              },
            ),
            ProgressScreen(
              habits: _habits,
            ),
            SettingsScreen(
              language: _language,
              isDarkMode: _isDarkMode,
              onLanguageChange: (language) {
                setState(() {
                  _language = language;
                });
              },
              onThemeChange: (isDarkMode) {
                setState(() {
                  _isDarkMode = isDarkMode;
                });
              },
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
            _habits.add(_Habit('', '', Icons.directions_run));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _Habit {
  String title;
  String description;
  IconData icon;

  _Habit(this.title, this.description, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<_Habit> habits;
  final VoidCallback addHabit;

  const HomeScreen({Key? key, required this.habits, required this.addHabit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(habits[index].icon),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habits[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          habits[index].description,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
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
  final List<_Habit> habits;

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits
            .map((habit) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        habit.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(width: 16),
                    LinearProgressIndicator(
                      value: 0.5,
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final String language;
  final bool isDarkMode;
  final void Function(String) onLanguageChange;
  final void Function(bool) onThemeChange;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.isDarkMode,
    required this.onLanguageChange,
    required this.onThemeChange,
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
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  widget.onLanguageChange(value as String);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Theme:'),
              const SizedBox(width: 16),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.onThemeChange(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}