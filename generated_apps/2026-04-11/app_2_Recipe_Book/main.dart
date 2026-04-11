import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isDark = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeTab(),
          ProgressTab(),
          SettingsTab(
            isDark: _isDark,
            language: _language,
            onDarkChanged: (value) {
              setState(() {
                _isDark = value;
              });
            },
            onLanguageChanged: (value) {
              setState(() {
                _language = value;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 48,
                  ),
                  Text(
                    'Recipe 1',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Description of recipe 1'),
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
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 48,
                  ),
                  Text(
                    'Recipe 2',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Description of recipe 2'),
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
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 48,
                  ),
                  Text(
                    'Recipe 3',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Description of recipe 3'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressTab extends StatelessWidget {
  const ProgressTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart),
              Text('Progress Indicator'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.bar_chart),
              Text('Progress Indicator 2'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  final bool isDark;
  final String language;
  final Function(bool) onDarkChanged;
  final Function(String) onLanguageChanged;

  const SettingsTab({
    Key? key,
    required this.isDark,
    required this.language,
    required this.onDarkChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode:'),
              Switch(
                value: isDark,
                onChanged: onDarkChanged,
              ),
            ],
          ),
          Row(
            children: [
              Text('Language:'),
              DropdownButton<String>(
                value: language,
                onChanged: onLanguageChanged,
                items: [
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'Turkish',
                    child: Text('Turkish'),
                  ),
                  DropdownMenuItem(
                    value: 'Spanish',
                    child: Text('Spanish'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}