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
  Locale _locale = const Locale('en');

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLanguage(String language) {
    Locale newLocale;
    switch (language) {
      case 'English':
        newLocale = const Locale('en');
        break;
      case 'Turkish':
        newLocale = const Locale('tr');
        break;
      case 'Spanish':
        newLocale = const Locale('es');
        break;
      default:
        newLocale = const Locale('en');
    }
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeRoulette',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      locale: _locale,
      home: MyHomePage(
        toggleTheme: _toggleTheme,
        changeLanguage: _changeLanguage,
        currentIndex: _currentIndex,
        onChangeIndex: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function toggleTheme;
  final Function changeLanguage;
  final int currentIndex;
  final Function onChangeIndex;

  MyHomePage({
    required this.toggleTheme,
    required this.changeLanguage,
    required this.currentIndex,
    required this.onChangeIndex,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(),
          ProgressScreen(),
          SettingsScreen(
            toggleTheme: widget.toggleTheme,
            changeLanguage: widget.changeLanguage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onChangeIndex(index);
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.food_bank),
                  SizedBox(width: 16),
                  Text(
                    'Recipe 1',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.food_bank),
                  SizedBox(width: 16),
                  Text(
                    'Recipe 2',
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

class ProgressScreen extends StatelessWidget {
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
              Text(
                'Progress',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Step 1',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.check),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Step 2',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.check),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function toggleTheme;
  final Function changeLanguage;

  SettingsScreen({
    required this.toggleTheme,
    required this.changeLanguage,
  });

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
              Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Theme',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  toggleTheme();
                },
                child: Text('Toggle'),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Language',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 16),
              DropdownButton(
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
                onChanged: (value) {
                  changeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}