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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(Locale locale) {
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
      home: const MyHomePage(),
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
  List<Habit> _habits = [
    Habit(title: 'Exercise', icon: Icons.directions_run, done: true),
    Habit(title: 'Meditation', icon: Icons.meditation, done: false),
    Habit(title: 'Reading', icon: Icons.book, done: true),
  ];

  void _addHabit() {
    setState(() {
      _habits.add(Habit(title: 'New Habit', icon: Icons.add, done: false));
    });
  }

  void _toggleHabit(Habit habit) {
    setState(() {
      habit.done = !habit.done;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(habits: _habits, onToggleHabit: _toggleHabit),
          ProgressScreen(habits: _habits),
          SettingsScreen(
            onToggleTheme: () {
              (context as Element).findAncestorStateOfType<_MyAppState>()!._toggleTheme();
            },
            onLanguageChanged: (locale) {
              (context as Element).findAncestorStateOfType<_MyAppState>()!._changeLocale(locale);
            },
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
    );
  }
}

class Habit {
  final String title;
  final IconData icon;
  bool done;

  Habit({required this.title, required this.icon, this.done = false});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final Function(Habit) onToggleHabit;

  const HomeScreen({Key? key, required this.habits, required this.onToggleHabit}) : super(key: key);

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
            child: ListTile(
              leading: Icon(habits[index].icon),
              title: Text(habits[index].title),
              trailing: Checkbox(
                value: habits[index].done,
                onChanged: (value) {
                  onToggleHabit(habits[index]);
                },
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Done'),
                    Text('${habits.where((habit) => habit.done).length}'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Total'),
                    Text('${habits.length}'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function onToggleTheme;
  final Function(Locale) onLanguageChanged;

  const SettingsScreen({Key? key, required this.onToggleTheme, required this.onLanguageChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            title: const Text('Theme'),
            trailing: Switch(
              value: (context as Element).findAncestorStateOfType<_MyAppState>()!._themeMode == ThemeMode.dark,
              onChanged: (value) {
                onToggleTheme();
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton(
              value: (context as Element).findAncestorStateOfType<_MyAppState>()!._locale,
              items: const [
                DropdownMenuItem(child: Text('English'), value: Locale('en')),
                DropdownMenuItem(child: Text('Turkish'), value: Locale('tr')),
                DropdownMenuItem(child: Text('Spanish'), value: Locale('es')),
              ],
              onChanged: (locale) {
                onLanguageChanged(locale as Locale);
              },
            ),
          ),
        ],
      ),
    );
  }
}