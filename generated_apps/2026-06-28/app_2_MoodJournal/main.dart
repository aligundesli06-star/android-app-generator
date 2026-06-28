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

  final List<MoodItem> _moodItems = [];
  final _formKey = GlobalKey<FormState>();
  final _moodController = TextEditingController();
  final _thoughtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mood Journal'),
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildProgressScreen();
      case 2:
        return _buildSettingsScreen();
      default:
        return const Center(
          child: Text('No screen found'),
        );
    }
  }

  Widget _buildHomeScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _moodItems.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _moodItems[index].mood,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  _moodItems[index].thought,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart),
              Text('Progress'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.arrow_upward),
              Text('Happy'),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.arrow_downward),
              Text('Sad'),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.arrow_forward),
              Text('Neutral'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode:'),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Language:'),
                const SizedBox(width: 16),
                DropdownButton(
                  value: _selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value as String;
                    });
                  },
                  items: [
                    'English',
                    'Turkish',
                    'Spanish',
                  ].map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  )).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _showAddMoodDialog,
      tooltip: 'Add Mood',
      child: const Icon(Icons.add),
    );
  }

  void _showAddMoodDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Mood'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _moodController,
                  decoration: const InputDecoration(
                    labelText: 'Mood',
                  ),
                ),
                TextFormField(
                  controller: _thoughtController,
                  decoration: const InputDecoration(
                    labelText: 'Thought',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _moodItems.add(
                      MoodItem(
                        mood: _moodController.text,
                        thought: _thoughtController.text,
                      ),
                    );
                  });
                  _moodController.clear();
                  _thoughtController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class MoodItem {
  final String mood;
  final String thought;

  MoodItem({
    required this.mood,
    required this.thought,
  });
}