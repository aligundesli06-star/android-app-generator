import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatefulWidget {
  const HabitTrackerApp({Key? key}) : super(key: key);

  @override
  State<HabitTrackerApp> createState() => _HabitTrackerAppState();
}

class _HabitTrackerAppState extends State<HabitTrackerApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  static const List<Locale> _supportedLocales = [
    const Locale('en'),
    const Locale('tr'),
    const Locale('es'),
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  final List<String> _habits = [];

  void _addHabit() {
    setState(() {
      _habits.add('New Habit ${_habits.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: _supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'HabitTracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: false,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
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
          onTap: (int index) {
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
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: _addHabit,
                child: const Icon(Icons.add),
              )
            : null,
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
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.directions_run),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Running'),
                      Text('30 minutes per day'),
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
                  title: 'Habits',
                  value: 10,
                ),
              ),
              Expanded(
                child: Indicator(
                  title: 'Streak',
                  value: 5,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Indicator(
                  title: 'Average',
                  value: 7,
                ),
              ),
              Expanded(
                child: Indicator(
                  title: 'Goal',
                  value: 10,
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

  const Indicator({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '$value',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
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
    HabitTrackerApp._toggleDarkMode();
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
    HabitTrackerApp._changeLocale(locale);
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
                onChanged: (value) {
                  _toggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _locale,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: Locale('es'),
                  ),
                ],
                onChanged: (Locale? value) {
                  _changeLocale(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}