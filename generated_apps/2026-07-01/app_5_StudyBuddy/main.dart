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
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
      routes: {
        '/settings': (context) => SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onToggleDarkMode: (value) {
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
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    ProgressTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
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
          // add new items
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.book),
                  SizedBox(width: 16.0),
                  Text('Flashcards'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.quiz),
                  SizedBox(width: 16.0),
                  Text('Practice Quizzes'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.group),
                  SizedBox(width: 16.0),
                  Text('Collaborate on Projects'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressTab extends StatelessWidget {
  const ProgressTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 16.0),
              Text('Progress'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: const [
              Expanded(
                child: Text('80%'),
              ),
              Text('Today'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: const [
              Expanded(
                child: Text('90%'),
              ),
              Text('This Week'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: const [
              Expanded(
                child: Text('85%'),
              ),
              Text('This Month'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings'),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final void Function(bool) onToggleDarkMode;
  final void Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onToggleDarkMode,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.onToggleDarkMode(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton(
                  value: widget.language,
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