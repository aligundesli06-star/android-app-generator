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
      title: 'FocusForge',
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
  List<String> _languages = const ['English', 'Turkish', 'Spanish'];
  String _selectedLanguage = 'English';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FocusForge'),
      ),
      body: _currentIndex == 0
          ? HomeScreen()
          : _currentIndex == 1
              ? ProgressScreen()
              : SettingsScreen(
                  isDarkMode: _isDarkMode,
                  languages: _languages,
                  selectedLanguage: _selectedLanguage,
                  onThemeChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                      if (_isDarkMode) {
                        MyApp().build(context).copyWith(
                          theme: ThemeData(
                            primarySwatch: Colors.indigo,
                            brightness: Brightness.dark,
                          ),
                        );
                      } else {
                        MyApp().build(context).copyWith(
                          theme: ThemeData(
                            primarySwatch: Colors.indigo,
                            brightness: Brightness.light,
                          ),
                        );
                      }
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
        onTap: (value) {
          setState(() {
            _currentIndex = value;
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
                children: [
                  const Icon(Icons.focus_weak),
                  const SizedBox(width: 16),
                  const Text(
                    'Stay focused with our productivity tools',
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.timer),
                  const SizedBox(width: 16),
                  const Text(
                    'Set timers to boost your concentration',
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.priority_high),
                  const SizedBox(width: 16),
                  const Text(
                    'Prioritize your tasks for maximum efficiency',
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
              const Text(
                'Your progress so far',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  const Text(
                    'Tasks completed',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    '12/20',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  const Text(
                    'Time spent',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    '5 hours',
                    style: TextStyle(fontSize: 24),
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

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final List<String> languages;
  final String selectedLanguage;
  final Function(bool)? onThemeChanged;
  final Function(String)? onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.languages,
    required this.selectedLanguage,
    this.onThemeChanged,
    this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark mode',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onThemeChanged?.call(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: selectedLanguage,
                items: languages
                    .map((language) => DropdownMenuItem(
                          child: Text(language),
                          value: language,
                        ))
                    .toList(),
                onChanged: (value) {
                  onLanguageChanged?.call(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}