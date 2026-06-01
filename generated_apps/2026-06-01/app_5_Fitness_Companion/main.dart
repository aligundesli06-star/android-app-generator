import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FitnessApp();
  }
}

class FitnessApp extends StatefulWidget {
  const FitnessApp({Key? key}) : super(key: key);

  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  final List<Workout> _workouts = [
    Workout('Chest', 'Monday', 30),
    Workout('Back', 'Tuesday', 30),
    Workout('Legs', 'Wednesday', 30),
    Workout('Shoulders', 'Thursday', 30),
    Workout('Arms', 'Friday', 30),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Companion',
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
          children: [
            HomeScreen(
              workouts: _workouts,
              addWorkout: () {
                setState(() {
                  _workouts.add(Workout('New Workout', 'New Day', 30));
                });
              },
            ),
            ProgressScreen(),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              selectedLanguage: _selectedLanguage,
              toggleDarkMode: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              changeLanguage: (language) {
                setState(() {
                  _selectedLanguage = language;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
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
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_currentIndex == 0) {
              setState(() {
                _workouts.add(Workout('New Workout', 'New Day', 30));
              });
            }
          },
          tooltip: 'Add Workout',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Workout> workouts;
  final VoidCallback addWorkout;

  const HomeScreen({
    Key? key,
    required this.workouts,
    required this.addWorkout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.fitness_center),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workouts[index].name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        workouts[index].day,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        '${workouts[index].duration} minutes',
                        style: Theme.of(context).textTheme.labelSmall,
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: Indicator(
                  label: 'Workouts',
                  value: 30,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Indicator(
                  label: 'Distance',
                  value: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: Indicator(
                  label: 'Calories',
                  value: 500,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Indicator(
                  label: 'Progress',
                  value: 80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String label;
  final double value;

  const Indicator({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final VoidCallback toggleDarkMode;
  final VoidCallback changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
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
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.selectedLanguage,
                onChanged: (value) {
                  if (value == 'English') {
                    widget.changeLanguage;
                  } else if (value == 'Turkish') {
                    widget.changeLanguage;
                  } else if (value == 'Spanish') {
                    widget.changeLanguage;
                  }
                },
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Workout {
  final String name;
  final String day;
  final int duration;

  Workout(this.name, this.day, this.duration);
}