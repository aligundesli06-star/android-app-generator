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
  bool _isDarkMode = false;
  String _language = 'English';
  int _currentIndex = 0;

  final List<String> _languages = ['English', 'Turkish', 'Spanish'];

  ThemeMode get _themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(
        isDarkMode: _isDarkMode,
        language: _language,
        toggleDarkMode: _toggleDarkMode,
        changeLanguage: _changeLanguage,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final void Function() toggleDarkMode;
  final void Function(String) changeLanguage;
  final int currentIndex;
  final void Function(int) onTap;

  const MyHomePage({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Exercise> _exercises = [
    Exercise('Push Ups', 'A classic exercise for the chest and triceps'),
    Exercise('Squats', 'A compound exercise for the legs and glutes'),
    Exercise('Lunges', 'A great exercise for the legs and glutes'),
  ];

  void _addExercise() {
    setState(() {
      _exercises.add(Exercise('New Exercise', 'Description'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            exercises: _exercises,
            language: widget.language,
          ),
          ProgressScreen(),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            toggleDarkMode: widget.toggleDarkMode,
            changeLanguage: widget.changeLanguage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
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
        onPressed: _addExercise,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Exercise {
  final String name;
  final String description;

  Exercise(this.name, this.description);
}

class HomeScreen extends StatelessWidget {
  final List<Exercise> exercises;
  final String language;

  const HomeScreen({
    super.key,
    required this.exercises,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercises[index].name,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  exercises[index].description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ProgressIndicator(
              title: 'Weight',
              value: 70,
              unit: 'kg',
            ),
            ProgressIndicator(
              title: 'Height',
              value: 180,
              unit: 'cm',
            ),
          ],
        ),
      ],
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final String title;
  final double value;
  final String unit;

  const ProgressIndicator({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          '$value$unit',
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final void Function() toggleDarkMode;
  final void Function(String) changeLanguage;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) => toggleDarkMode(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: language,
                onChanged: (value) => changeLanguage(value as String),
                items: _languages.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<String> get _languages => ['English', 'Turkish', 'Spanish'];
}

List<String> _languages = ['English', 'Turkish', 'Spanish'];