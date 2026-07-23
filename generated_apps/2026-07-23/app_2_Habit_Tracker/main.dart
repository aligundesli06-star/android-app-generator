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

  void _changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
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
      title: 'Habit Tracker',
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
        changeTheme: _changeTheme,
        locale: _locale,
        changeLanguage: _changeLanguage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ThemeMode themeMode;
  final Function changeTheme;
  final Locale locale;
  final Function changeLanguage;

  const MyHomePage({
    Key? key,
    required this.themeMode,
    required this.changeTheme,
    required this.locale,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Habit> _habits = [
    Habit(name: 'Running', icon: Icons.run, completed: [true, false, true]),
    Habit(name: 'Meditation', icon: Icons.meditation, completed: [false, true, false]),
    Habit(name: 'Reading', icon: Icons.book, completed: [true, true, true]),
  ];

  void _addHabit() {
    setState(() {
      _habits.add(Habit(
        name: 'New Habit',
        icon: Icons.add,
        completed: List.filled(7, false),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(habits: _habits),
          ProgressScreen(habits: _habits),
          SettingsScreen(
            themeMode: widget.themeMode,
            changeTheme: (mode) => widget.changeTheme(mode),
            locale: widget.locale,
            changeLanguage: (locale) => widget.changeLanguage(locale),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Habit {
  final String name;
  final IconData icon;
  final List<bool> completed;

  Habit({required this.name, required this.icon, required this.completed});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

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
                  Text(
                    habits[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
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

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits.map((habit) {
          return Row(
            children: habit.completed.map((completed) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: completed ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final Function changeTheme;
  final Locale locale;
  final Function changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.themeMode,
    required this.changeTheme,
    required this.locale,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) => changeTheme(value ? ThemeMode.dark : ThemeMode.light),
              ),
            ],
          ),
          Row(
            children: [
              Text('Language'),
              const Spacer(),
              DropdownButton(
                value: locale.languageCode,
                items: [
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
                onChanged: (value) {
                  if (value == 'en') {
                    changeLanguage(Locale('en'));
                  } else if (value == 'tr') {
                    changeLanguage(Locale('tr'));
                  } else if (value == 'es') {
                    changeLanguage(Locale('es'));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}