import 'package:flutter/material.dart';
import 'dart:async';

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
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream Diary',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light().copyWith(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IndexedStack(
            index: _currentIndex,
            children: [
              HomeScreen(),
              ProgressScreen(),
              SettingsScreen(
                onLanguageChanged: (language) {
                  setState(() {
                    _selectedLanguage = language;
                  });
                },
                onThemeChanged: (isDarkMode) {
                  setState(() {
                    _isDarkMode = isDarkMode;
                  });
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
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
            showDialog(
              context: context,
              builder: (context) {
                return AddDreamDialog();
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                Icon(Icons.moon),
                SizedBox(width: 16),
                Text('Recent Dreams'),
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
            child: Row(
              children: [
                Icon(Icons.cloud),
                SizedBox(width: 16),
                Text('Recurring Themes'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Dreams this week'),
                Text('5'),
              ],
            ),
            Column(
              children: [
                Text('Average sleep quality'),
                Text('7/10'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Longest dream'),
                Text('30 minutes'),
              ],
            ),
            Column(
              children: [
                Text('Average dream duration'),
                Text('15 minutes'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(String) onLanguageChanged;
  final Function(bool) onThemeChanged;

  SettingsScreen({required this.onLanguageChanged, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Theme'),
            Switch(
              value: false,
              onChanged: (value) {
                onThemeChanged(value);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Language'),
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
                onLanguageChanged(value as String);
              },
              value: 'English',
            ),
          ],
        ),
      ],
    );
  }
}

class AddDreamDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add Dream'),
            TextField(
              decoration: InputDecoration(
                labelText: 'Dream title',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Dream description',
              ),
              minLines: 5,
              maxLines: 10,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}