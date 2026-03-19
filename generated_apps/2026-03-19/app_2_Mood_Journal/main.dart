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
      title: 'Mood Journal',
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

  final _entries = <Entry>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_entries, _addEntry),
            ProgressScreen(_entries),
            SettingsScreen(_toggleDarkMode, _changeLanguage),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addEntry() {
    final entry = Entry(DateTime.now(), 'New Entry');
    setState(() => _entries.add(entry));
  }

  void _toggleDarkMode(bool value) {
    setState(() => _isDarkMode = value);
    if (_isDarkMode) {
      Theme.of(context).copyWith(
        splashColor: Colors.grey,
        canvasColor: Colors.grey[300],
      );
    } else {
      Theme.of(context).copyWith(
        splashColor: null,
        canvasColor: null,
      );
    }
  }

  void _changeLanguage(String language) {
    setState(() => _language = language);
  }
}

class HomeScreen extends StatelessWidget {
  final List<Entry> _entries;
  final Function _addEntry;

  const HomeScreen(this._entries, this._addEntry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.date.toString().split(' ').first,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  entry.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Entry> _entries;

  const ProgressScreen(this._entries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'Happy',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Sad',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Neutral',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function _toggleDarkMode;
  final Function _changeLanguage;

  const SettingsScreen(this._toggleDarkMode, this._changeLanguage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              Switch(
                value: false,
                onChanged: (value) => _toggleDarkMode(value),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              DropdownButton(
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
                onChanged: (value) => _changeLanguage(value.toString()),
                value: 'English',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Entry {
  final DateTime date;
  final String description;

  Entry(this.date, this.description);
}