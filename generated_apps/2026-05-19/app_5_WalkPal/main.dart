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
  bool isDarkMode = false;
  String language = 'English';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.indigo,
            ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkMode = false;
  String language = 'English';
  int _currentIndex = 0;
  List<String> routes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            onAddRoute: () {
              setState(() {
                routes.add('New Route');
              });
            },
            routes: routes,
          ),
          ProgressScreen(routes: routes),
          SettingsScreen(
            onThemeChanged: (bool value) {
              setState(() {
                isDarkMode = value;
              });
            },
            onLanguageChanged: (String value) {
              setState(() {
                language = value;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            routes.add('New Route');
          });
        },
        tooltip: 'Add New Route',
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function onAddRoute;
  final List<String> routes;

  HomeScreen({required this.onAddRoute, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.directions_walk),
                  SizedBox(width: 16),
                  Text('My Walks', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          ...routes.map((route) => Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.place),
                      SizedBox(width: 16),
                      Text(route, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              )).toList(),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<String> routes;

  ProgressScreen({required this.routes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress', style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 16),
          ...routes.map((route) => Row(
                children: [
                  Icon(Icons.directions_walk),
                  SizedBox(width: 16),
                  Text(route, style: TextStyle(fontSize: 16)),
                  SizedBox(width: 16),
                  Text('30 minutes', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              )).toList(),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function onThemeChanged;
  final Function onLanguageChanged;

  SettingsScreen({required this.onThemeChanged, required this.onLanguageChanged});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 16),
              Text('Settings', style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Dark Mode'),
              SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  widget.onThemeChanged(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Language'),
              SizedBox(width: 16),
              DropdownButton(
                value: language,
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
                onChanged: (String? value) {
                  setState(() {
                    language = value ?? 'English';
                  });
                  widget.onLanguageChanged(value ?? 'English');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}