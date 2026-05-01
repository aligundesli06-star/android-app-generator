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
      title: 'BookPal',
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
  String _language = 'English';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentIndex == 0
            ? HomeScreen()
            : _currentIndex == 1
                ? ProgressScreen()
                : SettingsScreen(
                    language: _language,
                    isDarkMode: _isDarkMode,
                    onChanged: (language, isDarkMode) {
                      setState(() {
                        _language = language;
                        _isDarkMode = isDarkMode;
                      });
                    },
                  ),
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
          // Add new item logic
        },
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
    return Column(
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
                const Icon(Icons.book),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Book Title', style: TextStyle(fontSize: 18)),
                    const Text('Author Name'),
                  ],
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
                const Icon(Icons.book),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Book Title', style: TextStyle(fontSize: 18)),
                    const Text('Author Name'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.bar_chart),
            const SizedBox(width: 16),
            const Text('Progress: 50%'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 16),
            const Text('Days left: 10'),
          ],
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String language;
  final bool isDarkMode;
  final Function(String, bool) onChanged;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.isDarkMode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Language:'),
            const SizedBox(width: 16),
            DropdownButton<String>(
              value: language,
              onChanged: (value) {
                onChanged(value!, isDarkMode);
              },
              items: const [
                DropdownMenuItem(child: Text('English'), value: 'English'),
                DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Dark mode:'),
            const SizedBox(width: 16),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                onChanged(language, value);
              },
            ),
          ],
        ),
      ],
    );
  }
}