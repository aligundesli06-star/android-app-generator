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
  Locale _locale = const Locale('en');

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'StepCounter',
      theme: _isDarkMode
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
          type: BottomNavigationBarType.fixed,
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
          onPressed: () {},
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
            elevation: 4,
            shadowColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.directions_walk),
                  const SizedBox(width: 16),
                  Text(
                    'Daily Steps',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shadowColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 16),
                  Text(
                    'Activity Calendar',
                    style: Theme.of(context).textTheme.titleLarge,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Steps'),
                  Text(
                    '1000',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Distance'),
                  Text(
                    '5 km',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Calories'),
                  Text(
                    '500',
                    style: Theme.of(context).textTheme.titleLarge,
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

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
                onChanged: _toggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _locale.languageCode,
                onChanged: (value) {
                  if (value == 'en') {
                    _changeLanguage(const Locale('en'));
                  } else if (value == 'tr') {
                    _changeLanguage(const Locale('tr'));
                  } else if (value == 'es') {
                    _changeLanguage(const Locale('es'));
                  }
                },
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