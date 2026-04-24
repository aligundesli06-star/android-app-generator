import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelDiary',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'en';

  final List<String> _images = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/301',
    'https://picsum.photos/200/302',
  ];

  final List<String> _titles = [
    'Trip to Paris',
    'Trip to Rome',
    'Trip to Barcelona',
  ];

  final List<String> _descriptions = [
    'Paris, the City of Light, is a must-visit destination.',
    'Rome, the Eternal City, is a city steeped in history.',
    'Barcelona, the capital of Catalonia, is a vibrant city.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            images: _images,
            titles: _titles,
            descriptions: _descriptions,
          ),
          ProgressScreen(),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            language: _language,
            onDarkModeChanged: (value) {
              setState(() {
                _isDarkMode = value;
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
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> images;
  final List<String> titles;
  final List<String> descriptions;

  const HomeScreen({
    Key? key,
    required this.images,
    required this.titles,
    required this.descriptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.network(
                    images[index],
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(descriptions[index]),
                    ],
                  ),
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
              Expanded(
                child: Indicator(
                  value: 0.3,
                  label: 'Trips',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Indicator(
                  value: 0.5,
                  label: 'Destinations',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Indicator(
            value: 0.8,
            label: 'Memories',
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final double value;
  final String label;

  const Indicator({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey[200],
          color: Theme.of(context).primaryColor,
        ),
        Text(label),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final void Function(bool) onDarkModeChanged;
  final void Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: widget.isDarkMode,
                onChanged: widget.onDarkModeChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.language,
                onChanged: widget.onLanguageChanged,
                items: const [
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
        ],
      ),
    );
  }
}