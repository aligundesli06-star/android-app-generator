import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final _plants = [
    {'name': 'Basil', 'watering': 'Daily', 'fertilization': 'Weekly', 'pruning': 'Monthly'},
    {'name': 'Rose', 'watering': 'Alternate days', 'fertilization': 'Monthly', 'pruning': 'Quarterly'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Garden',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(plants: _plants),
            ProgressScreen(plants: _plants),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onChangeDarkMode: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onChangeLanguage: (value) {
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _plants.add({
                'name': 'New Plant',
                'watering': 'Daily',
                'fertilization': 'Weekly',
                'pruning': 'Monthly',
              });
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> plants;

  const HomeScreen({Key? key, required this.plants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: plants.map((plant) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.plant, size: 40),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant['name']!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Watering: ${plant['watering']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fertilization: ${plant['fertilization']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pruning: ${plant['pruning']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Map<String, String>> plants;

  const ProgressScreen({Key? key, required this.plants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart, size: 40),
              const SizedBox(width: 16),
              const Text(
                'Progress',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Indicator(value: 0.5, label: 'Watering'),
              const SizedBox(width: 16),
              Indicator(value: 0.7, label: 'Fertilization'),
              const SizedBox(width: 16),
              Indicator(value: 0.3, label: 'Pruning'),
            ],
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final double value;
  final String label;

  const Indicator({Key? key, required this.value, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey,
          color: Colors.indigo,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onChangeDarkMode;
  final Function(String) onChangeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onChangeDarkMode,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.brightness_4, size: 40),
              const SizedBox(width: 16),
              const Text(
                'Dark mode',
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: onChangeDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.language, size: 40),
              const SizedBox(width: 16),
              const Text(
                'Language',
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: language,
                items: const [
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
                onChanged: onChangeLanguage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}