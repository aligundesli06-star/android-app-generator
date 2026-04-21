import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      title: 'Mood Journal',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
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
          onPressed: () {
            // Add new item
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.sentiment_satisfied,
                      size: 32,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Happy',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.sentiment_neutral,
                      size: 32,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Neutral',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.sentiment_dissatisfied,
                      size: 32,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Sad',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Happy',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Text(
                  '30%',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Neutral',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Text(
                  '20%',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Sad',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Text(
                  '50%',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
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
                Expanded(
                  child: Text(
                    'Language',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<String>(
                  value: _language,
                  onChanged: (value) {
                    setState(() {
                      _language = value!;
                    });
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
        ),
      ),
    );
  }
}