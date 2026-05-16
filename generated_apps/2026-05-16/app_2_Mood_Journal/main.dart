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
  List<Mood> _moods = [];

  @override
  void initState() {
    super.initState();
    _moods = [
      const Mood('Happy', 'I\'m feeling great today'),
      const Mood('Sad', 'I\'m feeling a bit down today'),
      const Mood('Neutral', 'I\'m feeling neutral today'),
    ];
  }

  void _addNewMood() {
    setState(() {
      _moods.insert(
        0,
        Mood(
          'New Mood',
          'New description',
        ),
      );
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: _currentIndex == 0
            ? _buildHomeScreen()
            : _currentIndex == 1
                ? _buildProgressScreen()
                : _buildSettingsScreen(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewMood,
        tooltip: 'Add new mood',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return ListView.builder(
      itemCount: _moods.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  _getMoodIcon(_moods[index].mood),
                  size: 32,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _moods[index].mood,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(_moods[index].description),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressScreen() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('Happy'),
            Text('Sad'),
            Text('Neutral'),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsScreen() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text('Dark mode:'),
            const SizedBox(
              width: 16,
            ),
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                _toggleDarkMode();
              },
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text('Language:'),
            const SizedBox(
              width: 16,
            ),
            DropdownButton(
              value: _language,
              onChanged: (String? value) {
                _selectLanguage(value!);
              },
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
            ),
          ],
        ),
      ],
    );
  }

  IconData _getMoodIcon(String mood) {
    switch (mood) {
      case 'Happy':
        return Icons.sentiment_very_satisfied;
      case 'Sad':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
}

class Mood {
  final String mood;
  final String description;

  const Mood(this.mood, this.description);
}