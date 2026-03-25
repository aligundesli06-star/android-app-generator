import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Language Learner',
      home: MyHomePage(),
    );
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

  final List<Lesson> _lessons = [
    Lesson('Introduction to Spanish', 'Learn basics of Spanish', Icons.language),
    Lesson('Conversational Spanish', 'Improve conversational skills', Icons.chat),
    Lesson('Spanish Grammar', 'Master Spanish grammar rules', Icons.book),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            lessons: _lessons,
            onFabPressed: () {
              setState(() {
                _lessons.add(Lesson('New Lesson', 'New lesson description', Icons.add));
              });
            },
          ),
          ProgressScreen(),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            language: _language,
            onDarkModeChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            onLanguageChanged: (value) {
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
          if (_currentIndex == 0) {
            setState(() {
              _lessons.add(Lesson('New Lesson', 'New lesson description', Icons.add));
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Lesson> lessons;
  final VoidCallback onFabPressed;

  const HomeScreen({
    Key? key,
    required this.lessons,
    required this.onFabPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(lessons[index].icon),
              title: Text(lessons[index].title),
              subtitle: Text(lessons[index].description),
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
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Progress')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Statistics')),
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
  final bool isDarkMode;
  final String language;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<String> onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
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
                onChanged: onDarkModeChanged,
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
                onChanged: onLanguageChanged,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Lesson {
  final String title;
  final String description;
  final IconData icon;

  Lesson(this.title, this.description, this.icon);
}