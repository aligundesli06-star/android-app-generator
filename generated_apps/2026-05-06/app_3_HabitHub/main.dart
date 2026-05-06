import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme();
  }
}

class DynamicTheme extends StatefulWidget {
  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitHub',
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _themeMode,
      home: const MyHomePage(),
      supportedLocales: const [
        Locale('en', ''),
        Locale('tr', ''),
        Locale('es', ''),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List Habits = [
    Habit('Exercise', Icons.directions_run, '30 minutes'),
    Habit('Reading', Icons.book, '1 hour'),
    Habit('Meditation', Icons.self_improvement, '15 minutes'),
  ];

  void _addNewHabit() {
    setState(() {
      Habits.add(Habit('New Habit', Icons.add, '1 hour'));
    });
  }

  void _onChangeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitHub'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(Habits: Habits),
          ProgressScreen(Habits: Habits),
          SettingsScreen(
            onChangeTheme: () {
              DynamicTheme? dynamicTheme = context.findAncestorWidgetOfExactType<DynamicTheme>();
              if (dynamicTheme != null) {
                dynamicTheme.setThemeMode(dynamicTheme._themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light);
              }
            },
            onChangeLocale: (locale) {
              DynamicTheme? dynamicTheme = context.findAncestorWidgetOfExactType<DynamicTheme>();
              if (dynamicTheme != null) {
                dynamicTheme.setLocale(locale);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewHabit,
        tooltip: 'Add New Habit',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onChangeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Habit> Habits;

  const HomeScreen({Key? key, required this.Habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: Habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Habits[index].icon),
                  const SizedBox(width: 16),
                  Text(
                    Habits[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Text(Habits[index].duration),
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
  final List<Habit> Habits;

  const ProgressScreen({Key? key, required this.Habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: Habits.map((habit) {
          return Row(
            children: [
              Text(habit.name),
              const Spacer(),
              LinearProgressIndicator(
                value: 0.5,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final void Function() onChangeTheme;
  final void Function(Locale) onChangeLocale;

  const SettingsScreen({Key? key, required this.onChangeTheme, required this.onChangeLocale}) : super(key: key);

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
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  onChangeTheme();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: Localizations.localeOf(context),
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: const Locale('en', ''),
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: const Locale('tr', ''),
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: const Locale('es', ''),
                  ),
                ],
                onChanged: (Locale? locale) {
                  onChangeLocale(locale!);
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
  final String name;
  final IconData icon;
  final String duration;

  Habit(this.name, this.icon, this.duration);
}