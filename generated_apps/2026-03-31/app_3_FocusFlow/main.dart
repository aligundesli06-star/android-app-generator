import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusFlow',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FocusFlow'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(
              onToggleDarkMode: (value) {
                setState(() {
                  _isDarkMode = value;
                  ThemeMode themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
                  ThemeData themeData = Theme.of(context).copyWith();
                  Theme.of(context).copyWith(
                    colorScheme: _isDarkMode ? const ColorScheme.dark() : const ColorScheme.light(),
                  );
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
        },
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Icon(Icons.timer),
                SizedBox(width: 16),
                Text('Pomodoro Timer'),
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
            child: Row(
              children: const [
                Icon(Icons.calendar_today),
                SizedBox(width: 16),
                Text('Customizable Schedules'),
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
            child: Row(
              children: const [
                Icon(Icons.focus_weak),
                SizedBox(width: 16),
                Text('Stay Focused'),
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
            child: Row(
              children: const [
                Icon(Icons.priority_high),
                SizedBox(width: 16),
                Text('Prioritize Tasks'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text('Today:'),
            SizedBox(width: 8),
            Text('3/5 tasks completed'),
          ],
        ),
        Row(
          children: const [
            Text('Yesterday:'),
            SizedBox(width: 8),
            Text('2/4 tasks completed'),
          ],
        ),
        Row(
          children: const [
            Text('This week:'),
            SizedBox(width: 8),
            Text('10/15 tasks completed'),
          ],
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function(bool) onToggleDarkMode;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    super.key,
    required this.onToggleDarkMode,
    required this.onLanguageChange,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Dark mode:'),
            const SizedBox(width: 16),
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                widget.onToggleDarkMode(value);
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text('Language:'),
            const SizedBox(width: 16),
            DropdownButton<String>(
              value: 'English',
              onChanged: (value) {
                widget.onLanguageChange(value.toString());
              },
              items: const [
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'Turkish',
                  child: Text('Turkish'),
                ),
                DropdownMenuItem(
                  value: 'Spanish',
                  child: Text('Spanish'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}