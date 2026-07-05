import 'package:flutter/material.dart';
import 'dart:async';

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

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(String locale) {
    setState(() {
      _locale = Locale(locale);
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
      home: MyHomePage(
        themeMode: _themeMode,
        toggleTheme: _toggleTheme,
        locale: _locale,
        changeLocale: _changeLocale,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ThemeMode themeMode;
  final Function toggleTheme;
  final Locale locale;
  final Function changeLocale;

  const MyHomePage({
    super.key,
    required this.themeMode,
    required this.toggleTheme,
    required this.locale,
    required this.changeLocale,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Habit> _habits = [
    Habit(
      title: 'Exercise',
      icon: Icons.directions_run,
      description: 'Exercise for 30 minutes',
      completed: true,
    ),
    Habit(
      title: 'Meditation',
      icon: Icons.meditation,
      description: 'Meditate for 10 minutes',
      completed: false,
    ),
    Habit(
      title: 'Reading',
      icon: Icons.book,
      description: 'Read for 30 minutes',
      completed: true,
    ),
  ];

  int _currentIndex = 0;

  void _addHabit() {
    setState(() {
      _habits.add(
        Habit(
          title: 'New Habit',
          icon: Icons.add,
          description: 'New habit description',
          completed: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            habits: _habits,
          ),
          ProgressScreen(
            habits: _habits,
          ),
          SettingsScreen(
            themeMode: widget.themeMode,
            toggleTheme: () => widget.toggleTheme(),
            locale: widget.locale.languageCode,
            changeLocale: (locale) => widget.changeLocale(locale),
          ),
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
        onPressed: _addHabit,
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
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
                  const Spacer(),
                  Checkbox(
                    value: habits[index].completed,
                    onChanged: (value) {},
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
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text('Completed: ${habits.where((habit) => habit.completed).length}'),
            ],
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text('Not Completed: ${habits.where((habit) => !habit.completed).length}'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final Function toggleTheme;
  final String locale;
  final Function changeLocale;

  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.toggleTheme,
    required this.locale,
    required this.changeLocale,
  });

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
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  toggleTheme();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: locale,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: Text('Español'),
                    value: 'es',
                  ),
                ],
                onChanged: (value) {
                  changeLocale(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Habit {
  final String title;
  final IconData icon;
  final String description;
  final bool completed;

  Habit({
    required this.title,
    required this.icon,
    required this.description,
    required this.completed,
  });
}