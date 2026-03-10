import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

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
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteIt',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: [
          const HomeScreen(),
          const ProgressScreen(),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            onDarkModeChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            language: _language,
            onLanguageChanged: (value) {
              setState(() {
                _language = value;
              });
            },
          ),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Progress',
              icon: Icon(Icons.bar_chart),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNoteScreen()),
            );
          },
          tooltip: 'Add Note',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: const [
          NoteCard(
            title: 'Meeting',
            icon: Icons.group,
            content: 'Team meeting at 2 PM',
          ),
          NoteCard(
            title: 'Shopping',
            icon: Icons.shopping_cart,
            content: 'Buy milk and eggs',
          ),
          NoteCard(
            title: 'Reminder',
            icon: Icons.alarm,
            content: 'Dentist appointment at 10 AM',
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Indicator(
                color: Colors.green,
                label: 'Completed',
              ),
              Indicator(
                color: Colors.yellow,
                label: 'In progress',
              ),
              Indicator(
                color: Colors.red,
                label: 'Pending',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Progress indicators'),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeChanged;
  final String language;
  final Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
    required this.language,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark mode'),
              Switch(
                value: isDarkMode,
                onChanged: onDarkModeChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),
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
            onChanged: onLanguageChanged,
          ),
        ],
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  const NoteCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String label;

  const Indicator({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      child: Text(label),
    );
  }
}

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Note',
          ),
        ),
      ),
    );
  }
}