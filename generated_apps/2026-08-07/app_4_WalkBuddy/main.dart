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
  bool isDarkMode = false;
  String language = 'English';
  int currentIndex = 0;
  int steps = 0;
  int distance = 0;
  int calories = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: MyHomePage(
        isDarkMode: isDarkMode,
        language: language,
        currentIndex: currentIndex,
        steps: steps,
        distance: distance,
        calories: calories,
        toggleDarkMode: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        changeLanguage: (value) {
          setState(() {
            language = value;
          });
        },
        updateData: (newSteps, newDistance, newCalories) {
          setState(() {
            steps = newSteps;
            distance = newDistance;
            calories = newCalories;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final int currentIndex;
  final int steps;
  final int distance;
  final int calories;
  final Function toggleDarkMode;
  final Function changeLanguage;
  final Function updateData;

  const MyHomePage({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.currentIndex,
    required this.steps,
    required this.distance,
    required this.calories,
    required this.toggleDarkMode,
    required this.changeLanguage,
    required this.updateData,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            steps: widget.steps,
            distance: widget.distance,
            calories: widget.calories,
            updateData: (newSteps, newDistance, newCalories) {
              widget.updateData(newSteps, newDistance, newCalories);
            },
          ),
          ProgressScreen(
            steps: widget.steps,
            distance: widget.distance,
            calories: widget.calories,
          ),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            toggleDarkMode: () {
              widget.toggleDarkMode();
            },
            changeLanguage: (value) {
              widget.changeLanguage(value);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.steps += 100;
            widget.distance += 1;
            widget.calories += 10;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int steps;
  final int distance;
  final int calories;
  final Function updateData;

  const HomeScreen({
    Key? key,
    required this.steps,
    required this.distance,
    required this.calories,
    required this.updateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
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
                      const Text(
                        'Steps',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '$steps',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.map),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Distance',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '$distance km',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.restaurant),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Calories',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '$calories',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
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
  final int steps;
  final int distance;
  final int calories;

  const ProgressScreen({
    Key? key,
    required this.steps,
    required this.distance,
    required this.calories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.directions_walk),
              const SizedBox(width: 16),
              Text(
                'Steps: $steps',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.map),
              const SizedBox(width: 16),
              Text(
                'Distance: $distance km',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.restaurant),
              const SizedBox(width: 16),
              Text(
                'Calories: $calories',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function toggleDarkMode;
  final Function changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
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
                value: widget.language,
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
                  widget.changeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}