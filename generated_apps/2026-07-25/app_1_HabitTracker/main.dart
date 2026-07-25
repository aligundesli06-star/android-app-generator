import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      locale: _locale,
      home: const MyHomePage(),
      routes: {
        '/home': (context) => MyHomePage(
              currentIndex: _currentIndex,
              themeMode: _themeMode,
              locale: _locale,
              onChangeThemeMode: (mode) {
                setState(() {
                  _themeMode = mode;
                });
              },
              onChangeLocale: (locale) {
                setState(() {
                  _locale = locale;
                });
              },
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final ThemeMode themeMode;
  final Locale locale;
  final void Function(ThemeMode) onChangeThemeMode;
  final void Function(Locale) onChangeLocale;

  const MyHomePage({
    super.key,
    required this.currentIndex,
    required this.themeMode,
    required this.locale,
    required this.onChangeThemeMode,
    required this.onChangeLocale,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Habit> _habits = [
    Habit('Exercise', Icons.running, 'Run 30 minutes'),
    Habit('Meditation', Icons.meditation, 'Meditate 15 minutes'),
    Habit('Reading', Icons.book, 'Read 1 chapter'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            habits: _habits,
            onAddHabit: () {
              setState(() {
                _habits.add(Habit('New Habit', Icons.add, 'Description'));
              });
            },
          ),
          ProgressScreen(habits: _habits),
          SettingsScreen(
            themeMode: widget.themeMode,
            locale: widget.locale,
            onChangeThemeMode: widget.onChangeThemeMode,
            onChangeLocale: widget.onChangeLocale,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                currentIndex: index,
                themeMode: widget.themeMode,
                locale: widget.locale,
                onChangeThemeMode: widget.onChangeThemeMode,
                onChangeLocale: widget.onChangeLocale,
              ),
            ),
          );
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
            _habits.add(Habit('New Habit', Icons.add, 'Description'));
          });
        },
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Habit {
  final String title;
  final IconData icon;
  final String description;

  Habit(this.title, this.icon, this.description);
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final void Function() onAddHabit;

  const HomeScreen({
    super.key,
    required this.habits,
    required this.onAddHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(habits[index].icon),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habits[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(habits[index].description),
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
  final List<Habit> habits;

  const ProgressScreen({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits.map((habit) {
          return Row(
            children: [
              Text(habit.title),
              const Spacer(),
              Text('0/7'),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final Locale locale;
  final void Function(ThemeMode) onChangeThemeMode;
  final void Function(Locale) onChangeLocale;

  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.locale,
    required this.onChangeThemeMode,
    required this.onChangeLocale,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'en';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.themeMode == ThemeMode.dark;
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
              const Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    widget.onChangeThemeMode(_isDarkMode ? ThemeMode.dark : ThemeMode.light);
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'en'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'tr'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'es'),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                    widget.onChangeLocale(_language == 'en'
                        ? const Locale('en')
                        : _language == 'tr'
                            ? const Locale('tr')
                            : const Locale('es'));
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