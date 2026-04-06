import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
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
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          ProgressScreen(),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            selectedLanguage: _selectedLanguage,
            onThemeToggle: (value) {
              setState(() {
                _isDarkMode = value;
                ThemeMode themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
                ThemeData themeData = themeMode == ThemeMode.dark
                    ? ThemeData(
                        primarySwatch: Colors.indigo,
                        brightness: Brightness.dark,
                      )
                    : ThemeData(
                        primarySwatch: Colors.indigo,
                        brightness: Brightness.light,
                      );
                context.findAncestorWidgetOfExactType<MaterialApp>()?.theme = themeData;
              });
            },
            onLanguageChange: (value) {
              setState(() {
                _selectedLanguage = value;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                  Icon(Icons.language),
                  SizedBox(width: 16),
                  Text('Language Basics', style: TextStyle(fontSize: 18)),
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.speach_bubble),
                  SizedBox(width: 16),
                  Text('Conversational Practice', style: TextStyle(fontSize: 18)),
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.book),
                  SizedBox(width: 16),
                  Text('Reading Comprehension', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
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
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              const Text('Progress', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 16),
              Text('50%', style: const TextStyle(fontSize: 18).copyWith(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              const Text('Language Mastery', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 16),
              Text('20%', style: const TextStyle(fontSize: 18).copyWith(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final void Function(bool) onThemeToggle;
  final void Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onThemeToggle,
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
              const Text('Dark Mode', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onThemeToggle(value);
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
                value: selectedLanguage,
                onChanged: (String? value) {
                  onLanguageChange(value!);
                },
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Turkish', child: Text('Turkish')),
                  DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}