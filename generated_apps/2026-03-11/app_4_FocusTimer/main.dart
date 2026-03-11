import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<FocusItem> _focusItems = [
    FocusItem(title: 'Work', duration: 25 * 60),
    FocusItem(title: 'Study', duration: 30 * 60),
  ];

  final List<ProgressItem> _progressItems = [
    ProgressItem(title: 'Today', progress: 0.5),
    ProgressItem(title: 'Yesterday', progress: 0.3),
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      if (_isDarkMode) {
        Theme.of(context).copyWith(
          brightness: Brightness.dark,
        );
      } else {
        Theme.of(context).copyWith(
          brightness: Brightness.light,
        );
      }
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _addNewFocusItem() {
    setState(() {
      _focusItems.add(FocusItem(title: 'New Item', duration: 25 * 60));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(_focusItems, _addNewFocusItem),
          ProgressScreen(_progressItems),
          SettingsScreen(_toggleDarkMode, _changeLanguage, _language, _isDarkMode),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFocusItem,
        tooltip: 'Add new item',
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<FocusItem> _focusItems;
  final Function _addNewFocusItem;

  const HomeScreen(this._focusItems, this._addNewFocusItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _focusItems.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.timer),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_focusItems[index].title, style: TextStyle(fontSize: 18)),
                      Text(Duration(minutes: _focusItems[index].duration ~/ 60).toString(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<ProgressItem> _progressItems;

  const ProgressScreen(this._progressItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _progressItems.map((item) {
          return Row(
            children: [
              Text(item.title, style: TextStyle(fontSize: 18)),
              SizedBox(width: 16),
              LinearProgressIndicator(value: item.progress),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function _toggleDarkMode;
  final Function _changeLanguage;
  final String _language;
  final bool _isDarkMode;

  const SettingsScreen(this._toggleDarkMode, this._changeLanguage, this._language, this._isDarkMode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode', style: TextStyle(fontSize: 18)),
              SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  _toggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language', style: TextStyle(fontSize: 18)),
              SizedBox(width: 16),
              DropdownButton(
                value: _language,
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
                onChanged: (value) {
                  _changeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FocusItem {
  String title;
  int duration;

  FocusItem({required this.title, required this.duration});
}

class ProgressItem {
  String title;
  double progress;

  ProgressItem({required this.title, required this.progress});
}