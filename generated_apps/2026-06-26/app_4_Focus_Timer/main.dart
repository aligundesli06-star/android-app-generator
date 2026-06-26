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
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Timer',
      theme: _darkMode ? ThemeData.dark() : ThemeData(primarySwatch: Colors.indigo),
      home: MyHomePage(darkMode: _darkMode, language: _language, onThemeChange: (value) {
        setState(() {
          _darkMode = value;
        });
      }, onLanguageChange: (value) {
        setState(() {
          _language = value;
        });
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool darkMode;
  final String language;
  final Function onThemeChange;
  final Function onLanguageChange;

  const MyHomePage({Key? key, required this.darkMode, required this.language, required this.onThemeChange, required this.onLanguageChange}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _pages = [Home(), Progress(), Settings()];
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item logic here
          print('Add new item');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.timer),
                  SizedBox(width: 16),
                  Text('Focus Timer', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.book),
                  SizedBox(width: 16),
                  Text('Productivity Tips', style: Theme.of(context).textTheme.titleLarge),
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
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  Text('Today:'),
                  SizedBox(width: 16),
                  Text('25 minutes', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              Row(
                children: [
                  Text('Week:'),
                  SizedBox(width: 16),
                  Text('150 minutes', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode:'),
              SizedBox(width: 16),
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  (context as Element).widget.onThemeChange!(value);
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language:'),
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
                  (context as Element).widget.onLanguageChange!(value);
                  setState(() {
                    _language = value as String;
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