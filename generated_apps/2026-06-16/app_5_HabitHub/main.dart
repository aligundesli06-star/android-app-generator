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
  bool _isDark = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitHub',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDark ? Brightness.dark : Brightness.light,
      ),
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              isDark: _isDark,
              language: _language,
              onThemeChanged: (dark) {
                setState(() {
                  _isDark = dark;
                });
              },
              onLanguageChanged: (lang) {
                setState(() {
                  _language = lang;
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

  final List<Widget> _children = [
    const HomeScreen(),
    const ProgressScreen(),
    const Center(child: Text('Settings Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item logic here
        },
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
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.run, size: 24),
                  SizedBox(width: 16),
                  Text('Exercise', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.book, size: 24),
                  SizedBox(width: 16),
                  Text('Reading', style: TextStyle(fontSize: 18)),
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
              Icon(Icons.circle, color: Colors.green, size: 24),
              SizedBox(width: 8),
              Text('Completed: 5/7', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.circle, color: Colors.red, size: 24),
              SizedBox(width: 8),
              Text('Missed: 2/7', style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final bool isDark;
  final String language;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.isDark,
    required this.language,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDark = false;
  String _language = '';

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
    _language = widget.language;
  }

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
                const Text('Dark Mode', style: TextStyle(fontSize: 18)),
                const Spacer(),
                Switch(
                  value: _isDark,
                  onChanged: (value) {
                    setState(() {
                      _isDark = value;
                    });
                    widget.onThemeChanged(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language', style: TextStyle(fontSize: 18)),
                const Spacer(),
                DropdownButton<String>(
                  value: _language,
                  onChanged: (String? value) {
                    setState(() {
                      _language = value ?? '';
                    });
                    widget.onLanguageChanged(value ?? '');
                  },
                  items: [
                    const DropdownMenuItem(
                      child: Text('English'),
                      value: 'English',
                    ),
                    const DropdownMenuItem(
                      child: Text('Turkish'),
                      value: 'Turkish',
                    ),
                    const DropdownMenuItem(
                      child: Text('Spanish'),
                      value: 'Spanish',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}