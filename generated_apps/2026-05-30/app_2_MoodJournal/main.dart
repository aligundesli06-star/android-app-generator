import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodJournal',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: MyHomePage(
        currentIndex: _currentIndex,
        isDarkMode: _isDarkMode,
        selectedLanguage: _selectedLanguage,
        onSettingsChanged: (newIndex, isDark, language) {
          setState(() {
            _currentIndex = newIndex;
            _isDarkMode = isDark;
            _selectedLanguage = language;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final bool isDarkMode;
  final String selectedLanguage;
  final void Function(int, bool, String) onSettingsChanged;

  const MyHomePage({
    Key? key,
    required this.currentIndex,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onSettingsChanged,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _moods = [
    Mood('Happy', 'I\'m feeling great today', 'assets/happy.png', Colors.amber),
    Mood('Sad', 'I\'m feeling down today', 'assets/sad.png', Colors.blue),
    Mood('Angry', 'I\'m feeling frustrated today', 'assets/angry.png', Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            moods: _moods,
          ),
          ProgressScreen(),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            selectedLanguage: widget.selectedLanguage,
            onSettingsChanged: (newIndex, isDark, language) {
              widget.onSettingsChanged(newIndex, isDark, language);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (newIndex) {
          widget.onSettingsChanged(newIndex, widget.isDarkMode, widget.selectedLanguage);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new mood
          _moods.add(Mood('New', 'Add a description', 'assets/new.png', Colors.green));
          setState(() {});
        },
        tooltip: 'Add new mood',
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Mood> moods;

  const HomeScreen({
    Key? key,
    required this.moods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    moods[index].image,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          moods[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(moods[index].description),
                      ],
                    ),
                  ),
                  Icon(moods[index].icon),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Progress indicator 1'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Progress indicator 2'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Progress indicator 3'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Progress indicator 4'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final void Function(int, bool, String) onSettingsChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onSettingsChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _selectedLanguage = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (newVal) {
                  setState(() {
                    _isDarkMode = newVal;
                  });
                  widget.onSettingsChanged(0, newVal, _selectedLanguage);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _selectedLanguage,
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
                onChanged: (newVal) {
                  setState(() {
                    _selectedLanguage = newVal as String;
                  });
                  widget.onSettingsChanged(0, _isDarkMode, newVal as String);
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
  final String title;
  final String description;
  final String image;
  final Color icon;

  const Mood(
    this.title,
    this.description,
    this.image,
    this.icon,
  );
}