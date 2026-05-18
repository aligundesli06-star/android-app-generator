import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'en';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [_HomeScreen(), _ProgressScreen(), _SettingsScreen()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new item
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New item added')));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _HomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.restaurant),
                  SizedBox(width: 16),
                  Text('Recipe 1', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.cake),
                  SizedBox(width: 16),
                  Text('Recipe 2', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ProgressScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress 1'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.trending_up),
              SizedBox(width: 16),
              Text('Progress 2'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _SettingsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode'),
              Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (value) => setState(() => _isDarkMode = value),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Language'),
              Spacer(),
              DropdownButton(
                value: _language,
                onChanged: (value) => setState(() => _language = value as String),
                items: [
                  DropdownMenuItem(child: Text('English'), value: 'en'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'tr'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'es'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}