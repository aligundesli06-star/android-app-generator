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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void _changeTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(String language) {
    setState(() {
      switch (language) {
        case 'English':
          _locale = const Locale('en');
          break;
        case 'Turkish':
          _locale = const Locale('tr');
          break;
        case 'Spanish':
          _locale = const Locale('es');
          break;
      }
    });
  }

  final _habits = [
    {'name': 'Exercise', 'icon': Icons.directions_run, 'description': 'Exercise for 30 minutes'},
    {'name': 'Meditation', 'icon': Icons.meditation, 'description': 'Meditate for 10 minutes'},
    {'name': 'Reading', 'icon': Icons.book, 'description': 'Read for 30 minutes'},
  ];

  void _addHabit() {
    setState(() {
      _habits.add({'name': 'New Habit', 'icon': Icons.add, 'description': 'New habit description'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habits: _habits),
            ProgressScreen(),
            SettingsScreen(
              changeTheme: _changeTheme,
              changeLocale: _changeLocale,
              currentTheme: _themeMode,
              currentLocale: _locale.languageCode,
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
          onPressed: _addHabit,
          tooltip: 'Add Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    habits[index]['icon'],
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habits[index]['name'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(habits[index]['description']),
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
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check),
                      const SizedBox(width: 16),
                      Text(
                        'Completed: 3',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.close),
                      const SizedBox(width: 16),
                      Text(
                        'Missed: 2',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.bar_chart),
                  const SizedBox(width: 16),
                  Text(
                    'Progress: 50%',
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

class SettingsScreen extends StatelessWidget {
  final Function changeTheme;
  final Function changeLocale;
  final ThemeMode currentTheme;
  final String currentLocale;

  const SettingsScreen({
    Key? key,
    required this.changeTheme,
    required this.changeLocale,
    required this.currentTheme,
    required this.currentLocale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.brightness_6),
                  const SizedBox(width: 16),
                  Text(
                    currentTheme == ThemeMode.light ? 'Light Mode' : 'Dark Mode',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Switch(
                    value: currentTheme == ThemeMode.light,
                    onChanged: (value) {
                      value ? changeTheme() : changeTheme();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 16),
                  Text(
                    currentLocale,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: currentLocale,
                    items: const [
                      DropdownMenuItem(child: Text('English'), value: 'en'),
                      DropdownMenuItem(child: Text('Turkish'), value: 'tr'),
                      DropdownMenuItem(child: Text('Spanish'), value: 'es'),
                    ],
                    onChanged: (value) {
                      changeLocale(value);
                    },
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