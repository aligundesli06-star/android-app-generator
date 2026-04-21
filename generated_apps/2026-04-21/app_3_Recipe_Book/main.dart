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
  List<String> _recipes = [];

  void _addRecipe() {
    setState(() {
      _recipes.add('New Recipe');
    });
  }

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
            HomeScreen(_recipes, _addRecipe),
            ProgressScreen(),
            SettingsScreen(
              _isDarkMode,
              _language,
              (bool value) => setState(() => _isDarkMode = value),
              (String value) => setState(() => _language = value),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addRecipe,
          tooltip: 'Add Recipe',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> _recipes;
  final VoidCallback _addRecipe;

  HomeScreen(this._recipes, this._addRecipe);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.restaurant),
                  SizedBox(width: 16),
                  Text(_recipes[index], style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
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
              Icon(Icons.check_circle),
              SizedBox(width: 16),
              Text('Completed Recipes', style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.timer),
              SizedBox(width: 16),
              Text('Cooking Time', style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool _isDarkMode;
  final String _language;
  final Function _toggleDarkMode;
  final Function _changeLanguage;

  SettingsScreen(this._isDarkMode, this._language, this._toggleDarkMode, this._changeLanguage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.brightness_6),
              SizedBox(width: 16),
              Text('Dark Mode', style: TextStyle(fontSize: 18)),
              Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (bool value) => _toggleDarkMode(value),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.language),
              SizedBox(width: 16),
              Text('Language', style: TextStyle(fontSize: 18)),
              Spacer(),
              DropdownButton(
                value: _language,
                onChanged: (String? value) => _changeLanguage(value!),
                items: [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Türkçe'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Español'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}