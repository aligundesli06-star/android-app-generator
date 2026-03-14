import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');
  int _currentIndex = 0;
  List<Habit> _habits = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: false,
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
              habits: _habits,
              setHabits: (newHabits) => setState(() => _habits = newHabits),
            ),
        '/progress': (context) => const ProgressPage(),
        '/settings': (context) => SettingsPage(
              themeMode: _themeMode,
              locale: _locale,
              setThemeMode: (newThemeMode) => setState(() => _themeMode = newThemeMode),
              setLocale: (newLocale) => setState(() => _locale = newLocale),
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Habit> habits;
  final Function setHabits;

  const MyHomePage({super.key, required this.habits, required this.setHabits});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.habits.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.alarm, size: 24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.habits[index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  widget.habits[index].description,
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_box, size: 24),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/progress');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String _name = '';
              String _description = '';

              return AlertDialog(
                title: const Text('Add Habit'),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value!,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) => _description = value!,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.setHabits([...widget.habits, Habit(_name, _description)]);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Progress', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.alarm, size: 24),
                SizedBox(width: 16),
                Text('Habits: 5/7'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.bar_chart, size: 24),
                SizedBox(width: 16),
                Text('Progress: 71%'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/progress');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final ThemeMode themeMode;
  final Locale locale;
  final Function setThemeMode;
  final Function setLocale;

  const SettingsPage({
    super.key,
    required this.themeMode,
    required this.locale,
    required this.setThemeMode,
    required this.setLocale,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Settings', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Dark Mode'),
                const SizedBox(width: 16),
                Switch(
                  value: widget.themeMode == ThemeMode.dark,
                  onChanged: (value) => widget.setThemeMode(value ? ThemeMode.dark : ThemeMode.light),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const SizedBox(width: 16),
                DropdownButton(
                  value: widget.locale.languageCode,
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
                    if (value == 'en') {
                      widget.setLocale(const Locale('en'));
                    } else if (value == 'tr') {
                      widget.setLocale(const Locale('tr'));
                    } else if (value == 'es') {
                      widget.setLocale(const Locale('es'));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/progress');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class Habit {
  final String name;
  final String description;

  Habit(this.name, this.description