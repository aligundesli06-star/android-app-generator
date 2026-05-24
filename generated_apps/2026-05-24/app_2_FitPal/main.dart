import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitPal',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(
              onDarkModeToggle: (value) => setState(() => _isDarkMode = value),
              onLanguageChange: (value) => setState(() => _language = value),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
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
          onPressed: () {},
          tooltip: 'Add new item',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.directions_walk),
                  SizedBox(width: 16),
                  Text(
                    'Walking',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text('10 km'),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.pool),
                  SizedBox(width: 16),
                  Text(
                    'Swimming',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text('5 km'),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.directions_walk),
              SizedBox(width: 16),
              Text('Walking distance: 50 km'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.pool),
              SizedBox(width: 16),
              Text('Swimming distance: 20 km'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onDarkModeToggle;
  final Function(String) onLanguageChange;

  SettingsScreen({required this.onDarkModeToggle, required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SwitchListTile(
            title: Text('Dark mode'),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: onDarkModeToggle,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            items: [
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
            onChanged: onLanguageChange,
          ),
        ],
      ),
    );
  }
}