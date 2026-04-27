import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<String> _languages = ['English', 'Turkish', 'Spanish'];
  final List<FocusItem> _focusItems = [
    FocusItem('Work', 25, Colors.red),
    FocusItem('Break', 5, Colors.green),
  ];

  void _addNewItem() {
    setState(() {
      _focusItems.add(FocusItem('New Item', 25, Colors.blue));
    });
  }

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
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_focusItems, _addNewItem),
            ProgressScreen(_focusItems),
            SettingsScreen(_toggleDarkMode, _changeLanguage, _language, _languages),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
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
          onPressed: _addNewItem,
          tooltip: 'Add New Item',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<FocusItem> _focusItems;
  final Function _addNewItem;

  const HomeScreen(this._focusItems, this._addNewItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _focusItems
            .map((item) => Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.timer, color: item.color),
                        const SizedBox(width: 16),
                        Text(item.title, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(width: 16),
                        Text('${item.duration} minutes', style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<FocusItem> _focusItems;

  const ProgressScreen(this._focusItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Completed: ${_focusItems.length}', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: 16),
              Text('Total: ${_focusItems.length * 25} minutes', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text('Progress', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function _toggleDarkMode;
  final Function _changeLanguage;
  final String _language;
  final List<String> _languages;

  const SettingsScreen(this._toggleDarkMode, this._changeLanguage, this._language, this._languages, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget._language;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  widget._toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Language', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: 16),
              DropdownButton(
                value: _selectedLanguage,
                items: widget._languages
                    .map((language) => DropdownMenuItem(
                          value: language,
                          child: Text(language),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value as String;
                    widget._changeLanguage(_selectedLanguage);
                  });
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
  final String title;
  final int duration;
  final Color color;

  FocusItem(this.title, this.duration, this.color);
}