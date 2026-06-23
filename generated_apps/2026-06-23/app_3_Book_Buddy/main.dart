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
      title: 'Book Buddy',
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
  String _language = 'English';

  final _books = [
    {'title': 'Book 1', 'author': 'Author 1'},
    {'title': 'Book 2', 'author': 'Author 2'},
    {'title': 'Book 3', 'author': 'Author 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _books.add({'title': 'New Book', 'author': 'New Author'});
          });
        },
        tooltip: 'Add New Book',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget get _screens => [
        HomeScreen(
          books: _books,
          isDarkMode: _isDarkMode,
          language: _language,
        ),
        ProgressScreen(
          isDarkMode: _isDarkMode,
          language: _language,
        ),
        SettingsScreen(
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
      ][_currentIndex];
}

class HomeScreen extends StatelessWidget {
  final List _books;
  final bool _isDarkMode;
  final String _language;

  const HomeScreen({
    Key? key,
    required this._books,
    required this._isDarkMode,
    required this._language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
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
                        Text(
                          _books[index]['title'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          _books[index]['author'],
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final bool _isDarkMode;
  final String _language;

  const ProgressScreen({
    Key? key,
    required this._isDarkMode,
    required this._language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.bar_chart),
                SizedBox(width: 16),
                Text('Reading Progress'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: const [
                      Text('Pages Read'),
                      Text('100'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      Text('Total Pages'),
                      Text('200'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool _isDarkMode;
  final String _language;
  final void Function(bool) _onDarkModeChanged;
  final void Function(String) _onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this._isDarkMode,
    required this._language,
    required this._onDarkModeChanged,
    required this._onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: _isDarkMode,
                  onChanged: _onDarkModeChanged,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton(
                  value: _language,
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
                  onChanged: _onLanguageChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}