import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TravelPalApp();
  }
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelPal',
      theme: _isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const ProgressScreen(),
            SettingsScreen(
              toggleDarkMode: _toggleDarkMode,
              changeLanguage: _changeLanguage,
              isDarkMode: _isDarkMode,
              language: _language,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
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
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.map),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Paris, France', style: TextStyle(fontSize: 18)),
                      Text('Eiffel Tower'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.map),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Rome, Italy', style: TextStyle(fontSize: 18)),
                      Text('Colosseum'),
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
              const Icon(Icons.check_circle),
              const SizedBox(width: 16),
              const Text('Trip planned'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.check_circle),
              const SizedBox(width: 16),
              const Text('Destination guides downloaded'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function toggleDarkMode;
  final Function changeLanguage;
  final bool isDarkMode;
  final String language;

  const SettingsScreen({
    Key? key,
    required this.toggleDarkMode,
    required this.changeLanguage,
    required this.isDarkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton<String>(
                value: language,
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
                  changeLanguage(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}