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
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDark = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Diary',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: TravelDiary(
        toggleTheme: () {
          setState(() {
            _isDark = !_isDark;
          });
        },
        language: _language,
        changeLanguage: (language) {
          setState(() {
            _language = language;
          });
        },
      ),
    );
  }
}

class TravelDiary extends StatefulWidget {
  final Function toggleTheme;
  final String language;
  final Function(String) changeLanguage;

  const TravelDiary({
    Key? key,
    required this.toggleTheme,
    required this.language,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  _TravelDiaryState createState() => _TravelDiaryState();
}

class _TravelDiaryState extends State<TravelDiary> {
  int _currentIndex = 0;

  final _pages = [
    Home(),
    Progress(),
    Settings(
      toggleTheme: () => widget.toggleTheme(),
      language: widget.language,
      changeLanguage: (language) => widget.changeLanguage(language),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Progress'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
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
                  const Icon(Icons.place),
                  const SizedBox(width: 16),
                  const Text('Trip to Paris'),
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
                  const Icon(Icons.restaurant),
                  const SizedBox(width: 16),
                  const Text('Food expenses'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.directions),
              const SizedBox(width: 16),
              const Text('Distance traveled: 1000 km'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.timer),
              const SizedBox(width: 16),
              const Text('Time spent: 10 days'),
            ],
          ),
        ],
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final Function toggleTheme;
  final String language;
  final Function(String) changeLanguage;

  const Settings({
    Key? key,
    required this.toggleTheme,
    required this.language,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode'),
              const Spacer(),
              Switch(
                value: true,
                onChanged: (value) {
                  toggleTheme();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: language,
                onChanged: (String? value) {
                  changeLanguage(value!);
                },
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}