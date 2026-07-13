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
        body: [
          const HomeScreen(),
          const ProgressScreen(),
          SettingsScreen(
            toggleDarkMode: _toggleDarkMode,
            changeLanguage: _changeLanguage,
            isDarkMode: _isDarkMode,
            language: _language,
          ),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Add new item',
          child: Icon(Icons.add),
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
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.place, size: 40),
                  SizedBox(width: 16),
                  Text(
                    'Destination Guides',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.checklist, size: 40),
                  SizedBox(width: 16),
                  Text(
                    'Packing Lists',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.calendar_today, size: 40),
                  SizedBox(width: 16),
                  Text(
                    'Itinerary Management',
                    style: TextStyle(fontSize: 20),
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
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(value: 0.3),
                ),
              ),
              Text('30% completed'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(value: 0.6),
                ),
              ),
              Text('60% completed'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(value: 0.9),
                ),
              ),
              Text('90% completed'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final void Function() toggleDarkMode;
  final void Function(String) changeLanguage;
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
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.brightness_4, size: 40),
                  const SizedBox(width: 16),
                  const Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      toggleDarkMode();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.language, size: 40),
                  const SizedBox(width: 16),
                  const Text(
                    'Language',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
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
                    onChanged: (String? value) {
                      changeLanguage(value!);
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