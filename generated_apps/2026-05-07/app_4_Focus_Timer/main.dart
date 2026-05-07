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
  String _language = 'English';

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            ProgressScreen(),
            SettingsScreen(
              language: _language,
              isDarkMode: _isDarkMode,
              onChangeLanguage: _changeLanguage,
              onToggleDarkMode: _toggleDarkMode,
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
          items: [
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
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeScreen({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                children: [
                  Icon(
                    Icons.timer,
                    size: 48,
                  ),
                  Text(
                    'Focus Timer',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Stay focused and avoid distractions'),
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
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 48,
                  ),
                  Text(
                    'Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Track your progress and stay motivated'),
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
                children: [
                  Icon(
                    Icons.settings,
                    size: 48,
                  ),
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Customize your experience'),
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
                children: [
                  Icon(
                    Icons.info,
                    size: 48,
                  ),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Learn more about the app'),
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
              Icon(
                Icons.bar_chart,
                size: 48,
              ),
              SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 24,
              ),
              SizedBox(width: 8),
              Text('Focus Time: 25 minutes'),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.timer_off,
                size: 24,
              ),
              SizedBox(width: 8),
              Text('Break Time: 5 minutes'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String language;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final Function(String) onChangeLanguage;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                size: 48,
              ),
              SizedBox(width: 16),
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(
                Icons.language,
                size: 24,
              ),
              SizedBox(width: 8),
              Text('Language:'),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: language,
                items: [
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
                onChanged: onChangeLanguage,
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                size: 24,
              ),
              SizedBox(width: 8),
              Text('Dark Mode:'),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onToggleDarkMode();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}