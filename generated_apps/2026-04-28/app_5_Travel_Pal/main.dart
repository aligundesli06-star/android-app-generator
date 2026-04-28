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
  String _language = 'English';

  final currencies = {
    'USD': 1.0,
    'EUR': 0.88,
    'GBP': 0.76,
    'TRY': 7.34,
    'ESP': 0.95,
  };

  final translations = {
    'English': {
      'hello': 'Hello',
      'goodbye': 'Goodbye',
    },
    'Turkish': {
      'hello': 'Merhaba',
      'goodbye': 'Görüşürüz',
    },
    'Spanish': {
      'hello': 'Hola',
      'goodbye': 'Adiós',
    },
  };

  final _items = [
    {'title': 'Item 1', 'description': 'This is item 1', 'progress': 0.5},
    {'title': 'Item 2', 'description': 'This is item 2', 'progress': 0.7},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Pal',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Travel Pal'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              currencies: currencies,
              translations: translations,
              language: _language,
            ),
            ProgressScreen(
              items: _items,
            ),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onLanguageChange: (language) {
                setState(() {
                  _language = language;
                });
              },
              onThemeChange: (isDarkMode) {
                setState(() {
                  _isDarkMode = isDarkMode;
                });
              },
            ),
          ],
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
            _items.add({
              'title': 'New Item',
              'description': 'This is a new item',
              'progress': 0.1,
            });
            setState(() {});
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Map<String, double> currencies;
  final Map<String, Map<String, String>> translations;
  final String language;

  HomeScreen({
    required this.currencies,
    required this.translations,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.language),
                  SizedBox(width: 16),
                  Text(
                    'Language: ${translations[language]['hello']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.monetization_on),
                  SizedBox(width: 16),
                  Text(
                    'Currency: 1 USD = ${currencies['EUR'].toStringAsFixed(2)} EUR',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.culture),
                  SizedBox(width: 16),
                  Text(
                    'Cultural Insight: Respect local customs',
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
  final List<Map<String, dynamic>> items;

  ProgressScreen({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Items:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text(
                '${items.length}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          items[index]['title'],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 16),
                        LinearProgressIndicator(
                          value: items[index]['progress'],
                          backgroundColor: Colors.grey.shade200,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(String) onLanguageChange;
  final Function(bool) onThemeChange;

  SettingsScreen({
    required this.isDarkMode,
    required this.language,
    required this.onLanguageChange,
    required this.onThemeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Dark Mode:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onThemeChange(value);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Language:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  onLanguageChange(value.toString());
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