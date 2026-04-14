import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MoodTracker',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Mood> _moods;
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _moods = [
      Mood('Happy', 'assets/happy.png'),
      Mood('Sad', 'assets/sad.png'),
      Mood('Angry', 'assets/angry.png'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      locale: _locale,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MoodTracker'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            Home(),
            ProgressScreen(_moods),
            Settings(_isDarkMode, (darkMode) {
              setState(() {
                _isDarkMode = darkMode;
              });
            }, _locale, (locale) {
              setState(() {
                _locale = locale;
              });
            }),
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
            setState(() {
              _moods.add(Mood('New Mood', 'assets/new.png'));
            });
          },
          tooltip: 'Add New Mood',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_satisfied, size: 36),
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
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.sentiment_dissatisfied, size: 36),
                  SizedBox(width: 16),
                  Text(
                    'Sad',
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
  final List<Mood> _moods;

  const ProgressScreen(this._moods, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(Icons.face, size: 36),
                      const Text('Mood'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(Icons.bar_chart, size: 36),
                      const Text('Progress'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Mood Progress',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: _moods
                        .map(
                          (mood) => Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                mood.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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

class Settings extends StatelessWidget {
  final bool _isDarkMode;
  final Function(bool) _onDarkModeChange;
  final Locale _locale;
  final Function(Locale) _onLocaleChange;

  const Settings(
    this._isDarkMode,
    this._onDarkModeChange,
    this._locale,
    this._onLocaleChange, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.dark_mode, size: 36),
                  const SizedBox(width: 16),
                  const Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 24),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isDarkMode,
                    onChanged: _onDarkModeChange,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.language, size: 36),
                  const SizedBox(width: 16),
                  const Text(
                    'Language',
                    style: TextStyle(fontSize: 24),
                  ),
                  const Spacer(),
                  DropdownButton(
                    isExpanded: false,
                    value: _locale.languageCode,
                    onChanged: (value) {
                      switch (value) {
                        case 'en':
                          _onLocaleChange(const Locale('en'));
                          break;
                        case 'tr':
                          _onLocaleChange(const Locale('tr'));
                          break;
                        case 'es':
                          _onLocaleChange(const Locale('es'));
                          break;
                        default:
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        child: Text('English'),
                        value: 'en',
                      ),
                      DropdownMenuItem(
                        child: Text('Türkçe'),
                        value: 'tr',
                      ),
                      DropdownMenuItem(
                        child: Text('Español'),
                        value: 'es',
                      ),
                    ],
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

class Mood {
  final String name;
  final String imagePath;

  Mood(this.name, this.imagePath);
}