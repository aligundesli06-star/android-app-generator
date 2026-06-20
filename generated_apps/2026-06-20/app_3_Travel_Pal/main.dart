import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const TravelPalApp());
}

class TravelPalApp extends StatefulWidget {
  const TravelPalApp({Key? key}) : super(key: key);

  @override
  State<TravelPalApp> createState() => _TravelPalAppState();
}

class _TravelPalAppState extends State<TravelPalApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Pal',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData.light().copyWith(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const ProgressScreen(),
            SettingsScreen(
              onLanguageChanged: (language) {
                setState(() {
                  _language = language;
                });
              },
              onDarkModeChanged: (isDarkMode) {
                setState(() {
                  _isDarkMode = isDarkMode;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new item
          },
          child: const Icon(Icons.add),
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
      child: ListView(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.place),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Destination 1',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Description of destination 1',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.directions),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transportation',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Description of transportation',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.hotel),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Accommodation',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Description of accommodation',
                        style: TextStyle(fontSize: 14),
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

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              const Text(
                'Progress',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(
            value: 0.5,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.check),
              const SizedBox(width: 16),
              const Text(
                'Task 1',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.check),
              const SizedBox(width: 16),
              const Text(
                'Task 2',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final void Function(String) onLanguageChanged;
  final void Function(bool) onDarkModeChanged;

  const SettingsScreen({
    Key? key,
    required this.onLanguageChanged,
    required this.onDarkModeChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 16),
              const Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    widget.onDarkModeChanged(value);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                items: [
                  const DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  const DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  const DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                    widget.onLanguageChanged(value as String);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}