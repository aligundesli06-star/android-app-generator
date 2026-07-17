import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyHomePage(),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  bool get isDarkMode => _isDarkMode;
  Locale get locale => _locale;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeLanguage(String language) {
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
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      locale: themeProvider.locale,
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HabitTracker(),
    );
  }
}

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  int _currentIndex = 0;
  final List<Habit> _habits = [
    Habit('Exercise', Icons.directions_run),
    Habit('Reading', Icons.book),
  ];

  void _addNewHabit() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final TextEditingController _controller = TextEditingController();
        final IconData? _icon;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter Habit',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.directions_run),
                    onPressed: () {
                      setState(() {
                        _habits.add(Habit(_controller.text, Icons.directions_run));
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.book),
                    onPressed: () {
                      setState(() {
                        _habits.add(Habit(_controller.text, Icons.book));
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitTracker'),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewHabit,
        tooltip: 'Add New Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Habit {
  final String title;
  final IconData icon;

  Habit(this.title, this.icon);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.directions_run, size: 32),
                  const SizedBox(width: 16),
                  Text(
                    'Exercise',
                    style: Theme.of(context).textTheme.titleLarge,
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
                children: [
                  const Icon(Icons.book, size: 32),
                  const SizedBox(width: 16),
                  Text(
                    'Reading',
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
  const ProgressScreen({super.key});

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
                  const Text('Days Completed'),
                  Text(
                    '10',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Days Missed'),
                  Text(
                    '2',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Longest Streak'),
                  Text(
                    '5',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Current Streak'),
                  Text(
                    '3',
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
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _languages = ['English', 'Turkish', 'Spanish'];
  final ThemeProvider _themeProvider = context.watch<ThemeProvider>();

  @override
  Widget build(BuildContext context) {
    final ThemeProvider _themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark Mode'),
              Switch(
                value: _themeProvider.isDarkMode,
                onChanged: (value) {
                  _themeProvider.toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Language'),
              DropdownButton(
                value: _languages.firstWhere((element) {
                  switch (element) {
                    case 'English':
                      return _themeProvider.locale == const Locale('en');
                    case 'Turkish':
                      return _themeProvider.locale == const Locale('tr');
                    case 'Spanish':
                      return _themeProvider.locale == const Locale('es');
                    default:
                      return false;
                  }
                }),
                items: _languages.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language),
                    onTap: () {
                      _themeProvider.changeLanguage(language);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}