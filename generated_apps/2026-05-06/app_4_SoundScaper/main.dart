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
  String _language = 'English';

  final List<Sound> _sounds = [
    const Sound('Rain', Icons.cloud),
    const Sound('Ocean', Icons.ocean),
    const Sound('Forest', Icons.nature),
  ];

  final List<ProgressIndicator> _progress = [
    const ProgressIndicator('Relaxation', 50),
    const ProgressIndicator('Focus', 20),
    const ProgressIndicator('Sleep', 10),
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _addNewSound() {
    setState(() {
      _sounds.add(const Sound('New Sound', Icons.music_note));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundScaper',
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
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeScreen(),
            _buildProgressScreen(),
            _buildSettingsScreen(),
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
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: _addNewSound,
                tooltip: 'Add new sound',
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: _sounds.map((sound) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(sound.icon, size: 40),
                  const SizedBox(height: 16),
                  Text(
                    sound.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgressScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _progress.map((indicator) {
          return Row(
            children: [
              Text(
                indicator.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              LinearProgressIndicator(
                value: indicator.value / 100,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode:'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: _changeLanguage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Sound {
  final String name;
  final IconData icon;

  const Sound(this.name, this.icon);
}

class ProgressIndicator {
  final String name;
  final int value;

  const ProgressIndicator(this.name, this.value);
}