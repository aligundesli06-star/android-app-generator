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
      title: 'HabitHero',
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
  final items = ['Walking', 'Reading', 'Meditation'];
  final _currentIndex = 0;
  final _language = 'English';
  final _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            items: items,
            addCallback: addNewItem,
          ),
          ProgressScreen(),
          SettingsScreen(
            language: _language,
            darkMode: _darkMode,
            changeLanguage: changeLanguage,
            changeDarkMode: changeDarkMode,
          ),
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
        onPressed: addNewItem,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addNewItem() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        items.add('New Habit');
      });
    });
  }

  void changeLanguage(String newLanguage) {
    setState(() {
      _language = newLanguage;
    });
  }

  void changeDarkMode(bool newDarkMode) {
    setState(() {
      _darkMode = newDarkMode;
    });
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> items;
  final VoidCallback addCallback;

  const HomeScreen({Key? key, required this.items, required this.addCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Habits',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.circle),
                        const SizedBox(width: 16),
                        Text(items[index]),
                      ],
                    ),
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Progress',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          const Text('Indicator 1'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Indicator 2'),
              const SizedBox(width: 16),
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String language;
  final bool darkMode;
  final VoidCallback changeLanguage;
  final VoidCallback changeDarkMode;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.darkMode,
    required this.changeLanguage,
    required this.changeDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              changeLanguage();
            },
            child: Text('Change Language: $language'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              changeDarkMode();
            },
            child: Text('Change Theme: ${darkMode ? 'Dark' : 'Light'}'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  changeLanguage();
                },
                child: const Text('English'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  changeLanguage();
                },
                child: const Text('Turkish'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  changeLanguage();
                },
                child: const Text('Spanish'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}