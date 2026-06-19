import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const HabitBuddyApp());
}

class HabitBuddyApp extends StatefulWidget {
  const HabitBuddyApp({super.key});

  @override
  State<HabitBuddyApp> createState() => _HabitBuddyAppState();
}

class _HabitBuddyAppState extends State<HabitBuddyApp> {
  bool _isDarkMode = false;
  String _languages = 'English';
  List<Habit> _habits = [];
  int _currentIndex = 0;

  void _toggleMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _addHabit() {
    setState(() {
      _habits.add(Habit(
        id: _habits.length,
        title: 'New Habit',
        progress: 0,
      ));
    });
  }

  void _updateHabit(Habit habit) {
    setState(() {
      _habits[_habits.indexWhere((h) => h.id == habit.id)] = habit;
    });
  }

  void _removeHabit(Habit habit) {
    setState(() {
      _habits.remove(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              habits: _habits,
              addHabit: _addHabit,
              updateHabit: _updateHabit,
              removeHabit: _removeHabit,
            ),
            ProgressScreen(habits: _habits),
            SettingsScreen(
              toggleMode: _toggleMode,
              isDarkMode: _isDarkMode,
              language: _languages,
              changeLanguage: (lang) {
                setState(() {
                  _languages = lang;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
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
}

class Habit {
  final int id;
  String title;
  int progress;

  Habit({required this.id, required this.title, required this.progress});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final VoidCallback addHabit;
  final Function(Habit) updateHabit;
  final Function(Habit) removeHabit;

  const HomeScreen({
    super.key,
    required this.habits,
    required this.addHabit,
    required this.updateHabit,
    required this.removeHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Icon(Icons.directions_run, size: 48),
                  Text('Exercise', style: TextStyle(fontSize: 24)),
                  Text('Stay active and healthy'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return HabitCard(
                  habit: habits[index],
                  updateHabit: updateHabit,
                  removeHabit: removeHabit,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  final Habit habit;
  final Function(Habit) updateHabit;
  final Function(Habit) removeHabit;

  const HabitCard({
    super.key,
    required this.habit,
    required this.updateHabit,
    required this.removeHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(habit.title, style: const TextStyle(fontSize: 18)),
                  Text('Progress: ${habit.progress}%'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updateHabit(Habit(
                  id: habit.id,
                  title: habit.title,
                  progress: habit.progress + 10,
                ));
              },
              child: const Text('Update'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                removeHabit(habit);
              },
              child: const Text('Remove'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Habit> habits;

  const ProgressScreen({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart, size: 48),
              const SizedBox(width: 8),
              const Text('Progress', style: TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return ProgressCard(habit: habits[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  final Habit habit;

  const ProgressCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(habit.title, style: const TextStyle(fontSize: 18)),
            LinearProgressIndicator(
              value: habit.progress / 100,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback toggleMode;
  final bool isDarkMode;
  final String language;
  final Function(String) changeLanguage;

  const SettingsScreen({
    super.key,
    required this.toggleMode,
    required this.isDarkMode,
    required this.language,
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
              const Icon(Icons.settings, size: 48),
              const SizedBox(width: 8),
              const Text('Settings', style: TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: toggleMode,
            child: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
          ),
          const SizedBox(height: 8),
          DropdownButton(
            value: language,
            items: const [
              DropdownMenuItem(child: Text('English'), value: 'English'),
              DropdownMenuItem(child: Text('Türkçe'), value: 'Turkish'),
              DropdownMenuItem(child: Text('Español'), value: 'Spanish'),
            ],
            onChanged: (value) {
              changeLanguage(value as String);
            },
          ),
        ],
      ),
    );
  }
}