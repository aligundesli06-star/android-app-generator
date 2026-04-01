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
  bool _isDarkMode = false;
  String _language = 'en';

  final _habitList = [
    Habit('Wake up early', Icons.wb_sunny, 'Every morning at 7:00 AM'),
    Habit('Exercise', Icons.directions_run, 'Every evening at 6:00 PM'),
    Habit('Read books', Icons.book, 'Every night before sleep'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: _isDarkMode
            ? const ColorScheme.dark().copyWith(secondary: Colors.grey)
            : const ColorScheme.light().copyWith(secondary: Colors.grey),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HabitBuddy'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [_HomeScreen(_habitList), _ProgressScreen(), _SettingsScreen()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _habitList.add(Habit(
                'New habit',
                Icons.add,
                'Choose a time',
              ));
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
  final String time;

  Habit(this.name, this.icon, this.time);
}

class _HomeScreen extends StatelessWidget {
  final List<Habit> _habitList;

  const _HomeScreen(this._habitList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: _habitList.map((habit) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(habit.icon),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(habit.time),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Indicator(label: 'Good habits', value: 70),
              Indicator(label: 'Bad habits', value: 30),
            ],
          ),
          const SizedBox(height: 32),
          Indicator(label: 'Progress', value: 50),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String label;
  final int value;

  const Indicator({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Text('$value%'),
      ],
    );
  }
}

class _SettingsScreen extends StatefulWidget {
  @override
  State<_SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<_SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'en';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark mode'),
            value: _isDarkMode,
            onChanged: (value) => _toggleDarkMode(),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton(
              value: _language,
              onChanged: (String? value) => _selectLanguage(value!),
              items: [
                const DropdownMenuItem(
                  child: Text('English'),
                  value: 'en',
                ),
                const DropdownMenuItem(
                  child: Text('Turkish'),
                  value: 'tr',
                ),
                const DropdownMenuItem(
                  child: Text('Spanish'),
                  value: 'es',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}