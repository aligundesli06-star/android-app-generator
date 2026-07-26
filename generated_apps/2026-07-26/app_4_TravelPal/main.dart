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
      title: 'TravelPal',
      theme: _isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TravelPal'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
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
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new item dialog
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add New Item'),
                  content: const Text('Enter new item details'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
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
                children: const [
                  Icon(Icons.place),
                  SizedBox(width: 16),
                  Text('Destination Guides'),
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
                children: const [
                  Icon(Icons.translate),
                  SizedBox(width: 16),
                  Text('Language Translation'),
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
                children: const [
                  Icon(Icons.money),
                  SizedBox(width: 16),
                  Text('Currency Conversion'),
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
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress Indicators'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.circle),
              SizedBox(width: 16),
              Text('Indicator 1'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.circle),
              SizedBox(width: 16),
              Text('Indicator 2'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                  });
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
                  setState(() {
                    _selectedLanguage = value ?? 'English';
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