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
      home: Scaffold(
        body: [
          const HomeScreen(),
          ProgressScreen(),
          SettingsScreen(
            onDarkModeChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            onLanguageChanged: (language) {
              setState(() {
                _language = language;
              });
            },
          ),
        ][_currentIndex],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new item
          },
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
                  Icon(Icons.book),
                  SizedBox(width: 16),
                  Text('Study Materials'),
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
                  Icon(Icons.calendar_today),
                  SizedBox(width: 16),
                  Text('Upcoming Exams'),
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
            children: const [
              Icon(Icons.circle, size: 16, color: Colors.green),
              SizedBox(width: 8),
              Text('Completed: 80%'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.circle, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text('Pending: 20%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
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
                value: Provider.of<MyApp>(context).isDarkMode,
                onChanged: (value) {
                  onDarkModeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButton(
            value: Provider.of<MyApp>(context).language,
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
              onLanguageChanged(value as String);
            },
          ),
        ],
      ),
    );
  }
}

class Provider with ChangeNotifier {
  static Provider of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<_MyAppState>()!;
  }

  final _MyAppState state;

  Provider(this.state);

  bool get isDarkMode => state._isDarkMode;
  String get language => state._language;
}