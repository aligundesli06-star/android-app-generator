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
      title: 'Travel Pal',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: _currentIndex == 0
            ? HomeScreen()
            : _currentIndex == 1
                ? ProgressScreen()
                : SettingsScreen(
                    isDarkMode: _isDarkMode,
                    selectedLanguage: _selectedLanguage,
                    onModeChange: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                    onLanguageChange: (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
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
          onPressed: () {
            // Add new item
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.place, size: 24),
                      SizedBox(width: 16),
                      Text(
                        'Destination Guides',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Explore popular destinations and get insider tips from locals.',
                  ),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.translate, size: 24),
                      SizedBox(width: 16),
                      Text(
                        'Language Translation',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Communicate with locals using our built-in language translator.',
                  ),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.currency_exchange, size: 24),
                      SizedBox(width: 16),
                      Text(
                        'Currency Exchange',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Get the latest exchange rates and convert currencies with ease.',
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
              Expanded(
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('50%', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Learning Progress',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('75%', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Travel Planning',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Function(bool) onModeChange;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onModeChange,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode'),
              Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: onModeChange,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Language'),
              Spacer(),
              DropdownButton(
                value: selectedLanguage,
                onChanged: (String? value) {
                  onLanguageChange(value!);
                },
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}