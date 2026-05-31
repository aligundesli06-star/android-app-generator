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
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Finder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
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
            BottomNavigationBarItem(icon: Icon(Icons.linear_progress), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _HomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: [
          _Card(
            title: 'Recipe 1',
            description: 'Description 1',
            icon: Icons.restaurant,
          ),
          _Card(
            title: 'Recipe 2',
            description: 'Description 2',
            icon: Icons.fastfood,
          ),
          _Card(
            title: 'Recipe 3',
            description: 'Description 3',
            icon: Icons.cake,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Indicator(title: 'Calories', value: '1000'),
              _Indicator(title: 'Protein', value: '50g'),
              _Indicator(title: 'Carbs', value: '200g'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Indicator(title: 'Fat', value: '20g'),
              _Indicator(title: 'Sugar', value: '50g'),
              _Indicator(title: 'Fiber', value: '10g'),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Dark Mode'),
              Switch(
                value: _isDarkMode,
                onChanged: (value) => setState(() => _isDarkMode = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Language'),
              DropdownButton(
                value: _language,
                onChanged: (value) => setState(() => _language = value as String),
                items: [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _Card({required String title, required String description, required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24),
            ),
            Text(description),
            Row(
              children: [
                Icon(icon),
                SizedBox(width: 8),
                Text('30 minutes'),
                SizedBox(width: 8),
                Icon(Icons.bar_chart),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _Indicator({required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}