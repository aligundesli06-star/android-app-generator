import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool isDarkMode = false;
  String language = 'English';

  final List<Mood> _moods = [
    Mood('Happy', Colors.green, Icons.sentiment_very_satisfied),
    Mood('Sad', Colors.blue, Icons.sentiment_very_dissatisfied),
    Mood('Angry', Colors.red, Icons.sentiment_dissatisfied),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_moods),
            ProgressScreen(),
            SettingsScreen(
              onThemeChanged: (theme) {
                setState(() {
                  isDarkMode = theme;
                });
              },
              onLanguageChanged: (lang) {
                setState(() {
                  language = lang;
                });
              },
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddMoodScreen()),
            );
          },
          tooltip: 'Add Mood',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Mood {
  final String name;
  final Color color;
  final IconData icon;

  Mood(this.name, this.color, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<Mood> _moods;

  const HomeScreen(this._moods, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _moods.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(_moods[index].icon, color: _moods[index].color),
                  const SizedBox(width: 16),
                  Text(_moods[index].name, style: Theme.of(context).textTheme.titleLarge),
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
              const Icon(Icons.bar_chart, size: 48),
              const SizedBox(width: 16),
              Text('Progress', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.sentiment_very_satisfied, size: 24),
                  const SizedBox(width: 8),
                  Text('Happy: 3', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.sentiment_very_dissatisfied, size: 24),
                  const SizedBox(width: 8),
                  Text('Sad: 2', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.sentiment_dissatisfied, size: 24),
                  const SizedBox(width: 8),
                  Text('Angry: 1', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function onThemeChanged;
  final Function onLanguageChanged;

  const SettingsScreen({super.key, required this.onThemeChanged, required this.onLanguageChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings, size: 48),
              const SizedBox(width: 16),
              Text('Settings', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  widget.onThemeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) {
                  setState(() {
                    language = value as String;
                  });
                  widget.onLanguageChanged(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mood'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Mood Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}