import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<Habit> _habits = [
    Habit('Exercise', Icons.directions_run),
    Habit('Meditation', Icons.self_improvement),
    Habit('Reading', Icons.book),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
       brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habits: _habits),
            ProgressScreen(),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onThemeModeChange: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onLanguageChange: (value) {
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _habits.add(Habit('New Habit', Icons.add));
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String name;
  final IconData icon;

  Habit(this.name, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(habits[index].icon, size: 24),
                  const SizedBox(width: 16),
                  Text(habits[index].name, style: Theme.of(context).textTheme.titleLarge),
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
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 16),
              Text('Completed: 50%', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.cancel, color: Colors.red),
              const SizedBox(width: 16),
              Text('Missed: 20%', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onThemeModeChange;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onThemeModeChange,
    required this.onLanguageChange,
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
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onThemeModeChange(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  onLanguageChange(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}