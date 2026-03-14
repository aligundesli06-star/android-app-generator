import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
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

  final List<Mood> _moods = [
    Mood('Happy', Colors.yellow),
    Mood('Sad', Colors.blue),
    Mood('Angry', Colors.red),
    Mood('Neutral', Colors.grey),
  ];

  final List<Progress> _progress = [
    Progress('Today', 50),
    Progress('This Week', 75),
    Progress('This Month', 25),
  ];

  void _addNewMood() {
    _moods.add(Mood('New', Colors.indigo));
    setState(() {});
  }

  void _toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    setState(() {});
  }

  void _changeLanguage(String language) {
    _language = language;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: [
          const HomeScreen(),
          ProgressScreen(progress: _progress),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            language: _language,
            onDarkModeChanged: _toggleDarkMode,
            onLanguageChanged: _changeLanguage,
          ),
        ][_currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewMood,
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.mood,
                    size: 48,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'How are you feeling today?',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.mood,
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Mood',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Progress> progress;

  const ProgressScreen({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.bar_chart,
                    size: 48,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Your Progress',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: progress.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          progress[index].name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${progress[index].progress}%',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final VoidCallback onDarkModeChanged;
  final VoidCallback onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      onDarkModeChanged();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'Language',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton(
                    value: language,
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
                      onLanguageChanged();
                    },
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
  final Color color;

  Mood(this.name, this.color);
}

class Progress {
  final String name;
  final int progress;

  Progress(this.name, this.progress);
}