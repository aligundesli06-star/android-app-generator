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
  String _locale = 'en';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: HomeScreen(
        currentIndex: _currentIndex,
        locale: _locale,
        isDarkMode: _isDarkMode,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onChangeLocale: (locale) {
          setState(() {
            _locale = locale;
          });
        },
        onChangeTheme: (isDarkMode) {
          setState(() {
            _isDarkMode = isDarkMode;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final int currentIndex;
  final String locale;
  final bool isDarkMode;
  final Function(int) onTap;
  final Function(String) onChangeLocale;
  final Function(bool) onChangeTheme;

  HomeScreen({
    Key? key,
    required this.currentIndex,
    required this.locale,
    required this.isDarkMode,
    required this.onTap,
    required this.onChangeLocale,
    required this.onChangeTheme,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _screens = [
    Home(),
    Progress(),
    Settings(
      onChangeLocale: (locale) {
        widget.onChangeLocale(locale);
      },
      onChangeTheme: (isDarkMode) {
        widget.onChangeTheme(isDarkMode);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onTap(index);
        },
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
        onPressed: () {
          // Add new item
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Home extends StatelessWidget {
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
                children: [
                  Icon(Icons.place),
                  SizedBox(width: 16),
                  Text(
                    'Destination',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 16),
                  Text(
                    'Itinerary',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 10,
                child: LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              SizedBox(width: 16),
              Text('30%'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 10,
                child: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              SizedBox(width: 16),
              Text('60%'),
            ],
          ),
        ],
      ),
    );
  }
}

class Settings extends StatefulWidget {
  final Function(String) onChangeLocale;
  final Function(bool) onChangeTheme;

  Settings({
    Key? key,
    required this.onChangeLocale,
    required this.onChangeTheme,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _locale = 'en';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              DropdownButton(
                value: _locale,
                onChanged: (String? value) {
                  setState(() {
                    _locale = value!;
                    widget.onChangeLocale(_locale);
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'es',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Theme',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    widget.onChangeTheme(_isDarkMode);
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