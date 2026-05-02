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
  final _habitList = <Habit>[];
  final _language = 'English';
  final _darkMode = false;
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.indigo,
    );

    return MaterialApp(
      title: 'Habit Tracker',
      theme: _darkMode ? theme.dark() : theme,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habitList: _habitList, addHabit: _addHabit),
            ProgressScreen(habitList: _habitList),
            SettingsScreen(
              darkMode: _darkMode,
              language: _language,
              toggleDarkMode: _toggleDarkMode,
              changeLanguage: _changeLanguage,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addHabit,
          tooltip: 'Add Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addHabit() {
    setState(() {
      _habitList.add(Habit(title: 'New Habit', completed: false, streak: 0));
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }
}

class Habit {
  final String title;
  final bool completed;
  final int streak;

  Habit({required this.title, required this.completed, required this.streak});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habitList;
  final Function addHabit;

  const HomeScreen({Key? key, required this.habitList, required this.addHabit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(habitList[index].completed ? Icons.check_box : Icons.check_box_outline_blank),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      habitList[index].title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Streak: ${habitList[index].streak} days',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
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
  final List<Habit> habitList;

  const ProgressScreen({Key? key, required this.habitList}) : super(key: key);

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
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Completed Habits: 0'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Total Habits: 0'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool darkMode;
  final String language;
  final Function toggleDarkMode;
  final Function changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.darkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: darkMode,
                onChanged: (value) => toggleDarkMode(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
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
                onChanged: (value) => changeLanguage(value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}