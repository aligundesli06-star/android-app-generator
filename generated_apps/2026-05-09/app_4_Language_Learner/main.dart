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
  String _selectedLanguage = 'English';

  final List<Lesson> _lessons = [
    const Lesson('Introduction to Spanish', 'Learn the basics of Spanish', Icons.language),
    const Lesson('Spanish Vocabulary', 'Expand your vocabulary in Spanish', Icons.book),
    const Lesson('Spanish Grammar', 'Learn the grammar rules of Spanish', Icons.edit),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learner',
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
        appBar: AppBar(
          title: const Text('Language Learner'),
        ),
        body: _currentIndex == 0
            ? HomeScreen(lessons: _lessons)
            : _currentIndex == 1
                ? const ProgressScreen()
                : SettingsScreen(
                    isDarkMode: _isDarkMode,
                    selectedLanguage: _selectedLanguage,
                    onThemeChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                    onLanguageChanged: (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
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
              _lessons.add(const Lesson('New Lesson', 'New lesson description', Icons.add));
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Lesson {
  final String title;
  final String description;
  final IconData icon;

  const Lesson(this.title, this.description, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<Lesson> lessons;

  const HomeScreen({Key? key, required this.lessons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(lessons[index].icon, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lessons[index].title, style: Theme.of(context).textTheme.titleLarge),
                        Text(lessons[index].description, style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
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
  const ProgressScreen({Key? key}) : super(key: key);

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
                    color: Colors.indigo.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Progress')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Target')),
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
                    color: Colors.indigo.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Completed Lessons')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Total Lessons')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final void Function(bool) onThemeChanged;
  final void Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _selectedLanguage = widget.selectedLanguage;
  }

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
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  widget.onThemeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value as String;
                  });
                  widget.onLanguageChanged(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}