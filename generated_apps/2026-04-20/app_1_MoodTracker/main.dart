import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      child: MaterialApp(
        title: 'MoodTracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class DynamicTheme extends StatefulWidget {
  final Widget child;

  const DynamicTheme({super.key, required this.child});

  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _darkMode = false;
  Locale? _locale;

  void toggleTheme() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void setLocale(Locale? locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      child: Localizations.override(
        context: context,
        locale: _locale,
        child: widget.child,
      ),
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
  List<Mood> _moods = [];
  final _moodController = TextEditingController();

  void addMood() {
    if (_moodController.text.isNotEmpty) {
      setState(() {
        _moods.add(Mood(_moodController.text));
        _moodController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          ProgressScreen(),
          SettingsScreen(),
        ],
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: TextField(
                  controller: _moodController,
                  decoration: const InputDecoration(hintText: 'Enter your mood'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: addMood,
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.sentiment_very_satisfied,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Happy',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.sentiment_neutral,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Neutral',
                    style: TextStyle(fontSize: 24),
                  ),
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          Row(
            children: [
              Icon(
                Icons.sentiment_very_satisfied,
                size: 32,
              ),
              SizedBox(width: 16),
              Text(
                'Happy: 50%',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.sentiment_neutral,
                size: 32,
              ),
              SizedBox(width: 16),
              Text(
                'Neutral: 30%',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  String _language = 'English';

  void toggleTheme() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

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
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 16),
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  toggleTheme();
                  (context as Element).findAncestorWidgetOfExactType<DynamicTheme>()?.toggleTheme();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
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
                  setState(() {
                    _language = value as String;
                  });
                  (context as Element).findAncestorWidgetOfExactType<DynamicTheme>()?.setLocale(_language == 'English'
                      ? const Locale('en')
                      : _language == 'Turkish'
                      ? const Locale('tr')
                      : const Locale('es'));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Mood {
  final String mood;

  const Mood(this.mood);
}