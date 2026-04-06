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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = Locale('en', '');
  final List<Locale> _locales = [
    Locale('en', ''),
    Locale('tr', ''),
    Locale('es', ''),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walk Buddy',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      locale: _locale,
      supportedLocales: _locales,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    ProgressScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
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
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                    Icon(Icons.directions_walk),
                    SizedBox(width: 16),
                    Text('Today\'s Goal: 10,000 steps', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 16),
                    Text('Weekly Challenge: Walk 50,000 steps', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Add New Item'),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
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
                  child: Column(
                    children: [
                      Text('Steps', style: Theme.of(context).textTheme.titleLarge),
                      Text('10,000', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Distance', style: Theme.of(context).textTheme.titleLarge),
                      Text('5 km', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Calories Burned', style: Theme.of(context).textTheme.titleLarge),
                      Text('500', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Time', style: Theme.of(context).textTheme.titleLarge),
                      Text('2 hours', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
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
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  int _languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Dark Mode'),
                SizedBox(width: 16),
                Switch(
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                      _darkMode ? ThemeMode.dark : ThemeMode.light;
                      MyApp().setState(() {
                        _darkMode ? _themeMode = ThemeMode.dark : _themeMode = ThemeMode.light;
                      });
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Language'),
                SizedBox(width: 16),
                DropdownButton(
                  value: _languageIndex,
                  onChanged: (value) {
                    setState(() {
                      _languageIndex = value as int;
                      switch (_languageIndex) {
                        case 0:
                          MyApp().setState(() {
                            _locale = Locale('en', '');
                          });
                          break;
                        case 1:
                          MyApp().setState(() {
                            _locale = Locale('tr', '');
                          });
                          break;
                        case 2:
                          MyApp().setState(() {
                            _locale = Locale('es', '');
                          });
                          break;
                      }
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('English'),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text('Turkish'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('Spanish'),
                      value: 2,
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