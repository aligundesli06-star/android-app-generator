import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme();
  }
}

class DynamicTheme extends StatefulWidget {
  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        canvasColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              isDarkMode: _isDarkMode,
              selectedLanguage: _selectedLanguage,
              onLanguageChanged: (language) {
                setState(() {
                  _selectedLanguage = language;
                });
              },
              onThemeChanged: (isDark) {
                setState(() {
                  _isDarkMode = isDark;
                });
              },
            ),
      },
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
  final TextEditingController _newItemController = TextEditingController();

  void _addItem() {
    setState(() {
      // Add new item logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          ProgressScreen(),
          Center(
            child: Text('Settings will be shown in the route'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 2) {
              Navigator.pushNamed(context, '/settings');
            }
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
        onPressed: _addItem,
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.language),
                  SizedBox(width: 16),
                  Text('Language Lessons', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.quiz),
                  SizedBox(width: 16),
                  Text('Quizzes', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.exercise),
                  SizedBox(width: 16),
                  Text('Exercises', style: TextStyle(fontSize: 18)),
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
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Progress: ', style: TextStyle(fontSize: 18)),
              Text('50%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Completed Lessons: ', style: TextStyle(fontSize: 18)),
              Text('10', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Remaining Lessons: ', style: TextStyle(fontSize: 18)),
              Text('20', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Function(String) onLanguageChanged;
  final Function(bool) onThemeChanged;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode: '),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.onThemeChanged(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language: '),
                const SizedBox(width: 16),
                DropdownButton(
                  value: widget.selectedLanguage,
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
                  onChanged: (value) {
                    widget.onLanguageChanged(value as String);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}