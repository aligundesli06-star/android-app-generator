import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
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
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<MoodItem> _moodItems = [
    MoodItem('Happiness', 'I am feeling happy today', Icons.smile),
    MoodItem('Sadness', 'I am feeling sad today', Icons.sentiment_dissatisfied),
    MoodItem('Anger', 'I am feeling angry today', Icons.sentiment_very_dissatisfied),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(moodItems: _moodItems, addMoodItem: () {
            setState(() {
              _moodItems.add(MoodItem('New Mood', 'New mood item', Icons.add));
            });
          }),
          ProgressScreen(moodItems: _moodItems),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            language: _language,
            toggleDarkMode: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            changeLanguage: (language) {
              setState(() {
                _language = language;
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
          setState(() {
            _moodItems.add(MoodItem('New Mood', 'New mood item', Icons.add));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MoodItem {
  final String name;
  final String description;
  final IconData icon;

  MoodItem(this.name, this.description, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<MoodItem> moodItems;
  final VoidCallback addMoodItem;

  const HomeScreen({Key? key, required this.moodItems, required this.addMoodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moodItems.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(moodItems[index].icon),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moodItems[index].name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(moodItems[index].description),
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
  final List<MoodItem> moodItems;

  const ProgressScreen({Key? key, required this.moodItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.smile),
                  Text(moodItems.where((item) => item.name == 'Happiness').length.toString()),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.sentiment_dissatisfied),
                  Text(moodItems.where((item) => item.name == 'Sadness').length.toString()),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.sentiment_very_dissatisfied),
                  Text(moodItems.where((item) => item.name == 'Anger').length.toString()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.bar_chart),
                  Text('Chart'),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.bar_chart),
                  Text('Chart'),
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
  final bool isDarkMode;
  final String language;
  final ValueChanged<bool> toggleDarkMode;
  final ValueChanged<String> changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: widget.isDarkMode,
                onChanged: widget.toggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: widget.language,
                onChanged: widget.changeLanguage,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}