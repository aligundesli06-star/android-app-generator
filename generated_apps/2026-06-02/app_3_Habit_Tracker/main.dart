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
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDarkMode = false;
  String _currentLanguage = 'English';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              onThemeChanged: _toggleDarkMode,
              onLanguageChanged: (value) {
                setState(() {
                  _currentLanguage = value;
                });
              },
            ),
      },
    );
  }
}

class SettingsPage extends StatefulWidget {
  final Function onThemeChanged;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: (context.findAncestorWidgetOfExactType<MaterialApp>() as MaterialApp).theme.brightness == Brightness.dark,
                  onChanged: (value) {
                    widget.onThemeChanged();
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton(
                  isDense: true,
                  value: (context.findAncestorWidgetOfExactType<MaterialApp>() as MaterialApp).locale.languageCode,
                  items: const [
                    DropdownMenuItem(
                      child: Text('English'),
                      value: 'en',
                    ),
                    DropdownMenuItem(
                      child: Text('Spanish'),
                      value: 'es',
                    ),
                    DropdownMenuItem(
                      child: Text('Turkish'),
                      value: 'tr',
                    ),
                  ],
                  onChanged: (value) {
                    widget.onLanguageChanged(value.toString());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Habit> _habits = [
    Habit(id: 1, title: 'Exercise', description: 'Go for a run'),
    Habit(id: 2, title: 'Meditation', description: 'Practice mindfulness'),
    Habit(id: 3, title: 'Reading', description: 'Read a book'),
  ];

  void _addHabit() {
    setState(() {
      _habits.add(
        Habit(
          id: _habits.length + 1,
          title: 'New Habit',
          description: 'New Habit Description',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            child: const Text('Settings'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.circle),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_habits[index].title, style: Theme.of(context).textTheme.titleLarge),
                            Text(_habits[index].description),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.bar_chart),
                    const Text('Progress'),
                    const Spacer(),
                    const Text('90%'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const Text('Habits Completed'),
                    const Spacer(),
                    const Text('20/30'),
                  ],
                ),
              ],
            ),
          ),
          const Center(
            child: Text('No settings available'),
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
  final int id;
  final String title;
  final String description;

  Habit({required this.id, required this.title, required this.description});
}