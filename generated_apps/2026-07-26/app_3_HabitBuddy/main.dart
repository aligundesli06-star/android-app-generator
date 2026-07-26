import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      child: const MyHomePage(),
    );
  }
}

class DynamicTheme extends StatefulWidget {
  final Widget child;

  const DynamicTheme({Key? key, required this.child}) : super(key: key);

  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool isDarkMode = false;
  String language = 'English';

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void changeLanguage(String lang) {
    setState(() {
      language = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(
        toggleTheme: toggleTheme,
        language: language,
        changeLanguage: changeLanguage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function toggleTheme;
  final String language;
  final Function changeLanguage;

  const MyHomePage({
    Key? key,
    required this.toggleTheme,
    required this.language,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _habits = [
    {'name': 'Exercise', 'icon': Icons.directions_run, 'progress': 0.5},
    {'name': 'Meditation', 'icon': Icons.accessibility, 'progress': 0.8},
    {'name': 'Reading', 'icon': Icons.book, 'progress': 0.2},
  ];

  void _addHabit() {
    final habit = {'name': 'New Habit', 'icon': Icons.add, 'progress': 0.0};
    setState(() {
      _habits.add(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Home(
            habits: _habits,
          ),
          Progress(),
          Settings(
            toggleTheme: widget.toggleTheme,
            language: widget.language,
            changeLanguage: widget.changeLanguage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
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
        onPressed: _addHabit,
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final List habits;

  const Home({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(habit['icon']),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit['name'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: habit['progress'],
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

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Progress',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.directions_run),
              SizedBox(width: 8),
              Text('Exercise: 50%'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.accessibility),
              SizedBox(width: 8),
              Text('Meditation: 80%'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.book),
              SizedBox(width: 8),
              Text('Reading: 20%'),
            ],
          ),
        ],
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final Function toggleTheme;
  final String language;
  final Function changeLanguage;

  const Settings({
    Key? key,
    required this.toggleTheme,
    required this.language,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 8),
              Switch(
                value: language == 'English' ? false : true,
                onChanged: (value) {
                  toggleTheme();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 8),
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
                  changeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}