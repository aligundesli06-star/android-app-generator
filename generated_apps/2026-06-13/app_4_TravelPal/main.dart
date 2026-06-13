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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const ProgressScreen(),
            SettingsScreen(
              onDarkModeChange: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onLanguageChange: (value) {
                setState(() {
                  _language = value;
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
            // Add new item logic here
          },
          tooltip: 'Add new item',
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
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.flight, size: 48),
                  const SizedBox(height: 16),
                  const Text('Flights', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.bed, size: 48),
                  const SizedBox(height: 16),
                  const Text('Hotels', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.directions, size: 48),
                  const SizedBox(height: 16),
                  const Text('Directions', style: TextStyle(fontSize: 24)),
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
              Icon(Icons.flight, size: 24),
              const SizedBox(width: 16),
              const Text('Flights: 50%'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.bed, size: 24),
              const SizedBox(width: 16),
              const Text('Hotels: 25%'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.directions, size: 24),
              const SizedBox(width: 16),
              const Text('Directions: 75%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onDarkModeChange;
  final Function(String) onLanguageChange;

  const SettingsScreen({Key? key, required this.onDarkModeChange, required this.onLanguageChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: context.watch<_MyAppState>()?._isDarkMode ?? false,
                onChanged: onDarkModeChange,
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton<String>(
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                value: context.watch<_MyAppState>()?._language,
                onChanged: onLanguageChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}