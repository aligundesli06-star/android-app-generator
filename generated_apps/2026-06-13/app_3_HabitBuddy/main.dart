import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const HabitBuddyApp());
}

class HabitBuddyApp extends StatefulWidget {
  const HabitBuddyApp({Key? key}) : super(key: key);

  @override
  State<HabitBuddyApp> createState() => _HabitBuddyAppState();
}

class _HabitBuddyAppState extends State<HabitBuddyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';
  List<Habit> _habits = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
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
          type: BottomNavigationBarType.fixed,
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
            Habit newHabit = Habit(
              title: 'New Habit',
              description: 'New habit description',
              startDate: DateTime.now(),
              frequency: 'Daily',
            );
            setState(() {
              _habits.add(newHabit);
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.run, size: 24),
                  SizedBox(width: 16),
                  Text(
                    'Exercise',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.book, size: 24),
                  SizedBox(width: 16),
                  Text(
                    'Reading',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.music, size: 24),
                  SizedBox(width: 16),
                  Text(
                    'Meditation',
                    style: TextStyle(fontSize: 18),
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

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Habit 1: ', style: TextStyle(fontSize: 18)),
              Text('3/7 days completed', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Habit 2: ', style: TextStyle(fontSize: 18)),
              Text('5/7 days completed', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Habit 3: ', style: TextStyle(fontSize: 18)),
              Text('2/7 days completed', style: TextStyle(fontSize: 18)),
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
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 16),
              DropdownButton(
                value: _selectedLanguage,
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
                  setState(() {
                    _selectedLanguage = value as String;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Habit {
  String title;
  String description;
  DateTime startDate;
  String frequency;

  Habit({
    required this.title,
    required this.description,
    required this.startDate,
    required this.frequency,
  });
}