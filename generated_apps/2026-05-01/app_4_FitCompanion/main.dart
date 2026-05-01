import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const FitCompanionApp());
}

class FitCompanionApp extends StatefulWidget {
  const FitCompanionApp({Key? key}) : super(key: key);

  @override
  State<FitCompanionApp> createState() => _FitCompanionAppState();
}

class _FitCompanionAppState extends State<FitCompanionApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [HomeScreen(), ProgressScreen(), SettingsScreen()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new item logic
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  const Icon(Icons.directions_run),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Morning Run', style: TextStyle(fontSize: 18)),
                      Text('30 minutes, 5 km'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.restaurant),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Healthy Meal', style: TextStyle(fontSize: 18)),
                      Text('Grilled chicken, vegetables'),
                    ],
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
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          Row(
            children: [
              Expanded(
                child: Indicator(
                  title: 'Workouts',
                  value: 10,
                  maxValue: 20,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Indicator(
                  title: 'Distance',
                  value: 50,
                  maxValue: 100,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Indicator(
                  title: 'Calories',
                  value: 500,
                  maxValue: 1000,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Indicator(
                  title: 'Protein',
                  value: 50,
                  maxValue: 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String title;
  final int value;
  final int maxValue;

  const Indicator({Key? key, required this.title, required this.value, required this.maxValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        SizedBox(
          height: 16,
          child: LinearProgressIndicator(
            value: value / maxValue,
          ),
        ),
        const SizedBox(height: 8),
        Text('$value/$maxValue', style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'English';

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
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    (context as Element).ancestorWidgetOfExactType<_FitCompanionAppState>()!.setState(() {
                      (context as Element).ancestorWidgetOfExactType<_FitCompanionAppState>()!._isDarkMode = value;
                    });
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
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
                onChanged: (String? value) {
                  setState(() {
                    _language = value ?? 'English';
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