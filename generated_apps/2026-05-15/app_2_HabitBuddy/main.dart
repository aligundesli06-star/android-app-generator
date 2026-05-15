import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HabitBuddyApp();
  }
}

class HabitBuddyApp extends StatefulWidget {
  const HabitBuddyApp({super.key});

  @override
  State<HabitBuddyApp> createState() => _HabitBuddyAppState();
}

class _HabitBuddyAppState extends State<HabitBuddyApp> {
  int _currentIndex = 0;
  bool _darkMode = false;
  Locale? _locale;
  final List<Locale> _supportedLocales = const [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
    Locale('es', 'ES'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      theme: _darkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
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
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Add new habit',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.directions_run,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Exercise',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.book,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Reading',
                    style: TextStyle(fontSize: 24),
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: ProgressIndicator(),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ProgressIndicator(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: ProgressIndicator(),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ProgressIndicator(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LinearProgressIndicator(
          value: 0.5,
        ),
        const SizedBox(height: 8),
        const Text(
          '75%',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  int _languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark mode',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: _languageIndex,
                onChanged: (value) {
                  setState(() {
                    _languageIndex = value!;
                  });
                },
                items: const [
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
    );
  }
}