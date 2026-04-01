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
  bool _darkMode = false;
  String _language = 'English';
  int _steps = 0;
  int _exercises = 0;
  int _activities = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StepUp',
      theme: _darkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              steps: _steps,
              exercises: _exercises,
              activities: _activities,
              onPressed: () {
                setState(() {
                  _steps++;
                  _exercises++;
                  _activities++;
                });
              },
            ),
            ProgressScreen(
              steps: _steps,
              exercises: _exercises,
              activities: _activities,
            ),
            SettingsScreen(
              darkMode: _darkMode,
              language: _language,
              onDarkModeChanged: (value) {
                setState(() {
                  _darkMode = value;
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
            setState(() {
              _steps++;
              _exercises++;
              _activities++;
            });
          },
          tooltip: 'Add new item',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int steps;
  final int exercises;
  final int activities;
  final VoidCallback onPressed;

  const HomeScreen({
    Key? key,
    required this.steps,
    required this.exercises,
    required this.activities,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.directions_walk),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Steps',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        steps.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
              child: Row(
                children: [
                  const Icon(Icons.fitbit),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exercises',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        exercises.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
              child: Row(
                children: [
                  const Icon(Icons.pedal_bike),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Activities',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        activities.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Add new item'),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final int steps;
  final int exercises;
  final int activities;

  const ProgressScreen({
    Key? key,
    required this.steps,
    required this.exercises,
    required this.activities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Steps',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    steps.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    'Exercises',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    exercises.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    'Activities',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    activities.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Your progress will be displayed here',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool darkMode;
  final String language;
  final VoidCallback onDarkModeChanged;
  final VoidCallback onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.darkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark mode',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              Switch(
                value: darkMode,
                onChanged: (value) {
                  onDarkModeChanged();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  onLanguageChanged();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}