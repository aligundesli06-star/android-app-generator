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
  String _language = 'English';
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo, brightness: _darkMode ? Brightness.dark : Brightness.light),
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

  final _pages = [
    const HomeScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add new recipe',
        child: const Icon(Icons.add),
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
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.restaurant, size: 40),
                  const Text('Recipe 1', style: TextStyle(fontSize: 16)),
                  const Text('Description of recipe 1', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.cake, size: 40),
                  const Text('Recipe 2', style: TextStyle(fontSize: 16)),
                  const Text('Description of recipe 2', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.local_pizza, size: 40),
                  const Text('Recipe 3', style: TextStyle(fontSize: 16)),
                  const Text('Description of recipe 3', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.icecream, size: 40),
                  const Text('Recipe 4', style: TextStyle(fontSize: 16)),
                  const Text('Description of recipe 4', style: TextStyle(fontSize: 12)),
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
              const Text('Progress', style: TextStyle(fontSize: 24)),
              const Spacer(),
              const Icon(Icons.bar_chart, size: 24),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Meals cooked: 10', style: TextStyle(fontSize: 16)),
              const Spacer(),
              const Text('Meals planned: 5', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Grocery list: 15 items', style: TextStyle(fontSize: 16)),
              const Spacer(),
              const Text('Pantry: 20 items', style: TextStyle(fontSize: 16)),
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
  String _language = 'English';
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Settings', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark mode:'),
              const Spacer(),
              Switch(
                value: _darkMode,
                onChanged: (value) => setState(() => _darkMode = value),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const Spacer(),
              DropdownButton(
                value: _language,
                onChanged: (value) => setState(() => _language = value as String),
                items: [
                  const DropdownMenuItem(child: Text('English'), value: 'English'),
                  const DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  const DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}