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
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
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

  final pages = const [
    HomePage(),
    ProgressPage(),
    SettingsPage(
      isDarkMode: false,
      language: 'English',
      onDarkModeChanged: null,
      onLanguageChanged: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item functionality
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (_currentIndex == 2) {
            Navigator.pushNamed(context, '/settings');
            Timer(const Duration(milliseconds: 1), () {
              setState(() {
                _currentIndex = 0;
              });
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool)? onDarkModeChanged;
  final Function(String)? onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.language,
    this.onDarkModeChanged,
    this.onLanguageChanged,
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
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    if (widget.onDarkModeChanged != null) {
                      widget.onDarkModeChanged!(value);
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton(
                  value: widget.language,
                  items: const [
                    DropdownMenuItem(child: Text('English'), value: 'English'),
                    DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                    DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                  ],
                  onChanged: (value) {
                    if (widget.onLanguageChanged != null) {
                      widget.onLanguageChanged!(value as String);
                    }
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitnessFusion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(Icons.directions_run, size: 40),
                    Text('Running'),
                    Text('30 minutes'),
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
                child: Column(
                  children: const [
                    Icon(Icons.pool, size: 40),
                    Text('Swimming'),
                    Text('45 minutes'),
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
                child: Column(
                  children: const [
                    Icon(Icons.yoga, size: 40),
                    Text('Yoga'),
                    Text('60 minutes'),
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
                child: Column(
                  children: const [
                    Icon(Icons.dining, size: 40),
                    Text('Diet'),
                    Text('Balanced'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Row(
              children: [
                Text(
                  'Steps',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  '10,000',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Distance',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  '10 km',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Calories',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  '500',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}