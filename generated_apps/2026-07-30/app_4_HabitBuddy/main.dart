import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
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
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.light;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Theme:'),
              Switch(
                value: _themeMode == ThemeMode.dark,
                onChanged: (value) {
                  setState(() {
                    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                    (_themeMode == ThemeMode.dark)
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language:'),
              DropdownButton(
                value: _language,
                items: [
                  const DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  const DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  const DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value.toString();
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

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Habit Progress',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: ListTile(
                  title: Text('Today'),
                  subtitle: Text('4/5'),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('This Week'),
                  subtitle: Text('12/14'),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: ListTile(
                  title: Text('This Month'),
                  subtitle: Text('20/25'),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Total'),
                  subtitle: Text('50/60'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.directions_run, size: 40),
                  const SizedBox(height: 16),
                  const Text('Exercise'),
                  const SizedBox(height: 16),
                  const Text('30 minutes, 3 times a week'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.book, size: 40),
                  const SizedBox(height: 16),
                  const Text('Reading'),
                  const SizedBox(height: 16),
                  const Text('30 minutes, every day'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.meditation, size: 40),
                  const SizedBox(height: 16),
                  const Text('Meditation'),
                  const SizedBox(height: 16),
                  const Text('10 minutes, every day'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.golf_course, size: 40),
                  const SizedBox(height: 16),
                  const Text('Golf'),
                  const SizedBox(height: 16),
                  const Text('2 hours, every week'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HabitBuddy extends StatefulWidget {
  const HabitBuddy({super.key});

  @override
  State<HabitBuddy> createState() => _HabitBuddyState();
}

class _HabitBuddyState extends State<HabitBuddy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new habit
        },
        child: const Icon(Icons.add),
      ),
      body: const IndexedStack(
        index: 0,
        children: [
          HomeScreen(),
          ProgressScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}