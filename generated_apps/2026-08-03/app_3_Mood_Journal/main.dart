import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(String code) {
    setState(() {
      _locale = Locale(code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'Mood Journal',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
      routes: {
        '/settings': (context) => SettingsScreen(
              themeMode: _themeMode,
              onThemeChange: _toggleTheme,
              locale: _locale,
              onLocaleChange: _changeLocale,
            ),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _entries = [
    Entry(
      mood: 'Happy',
      description: 'I\'m feeling great today!',
      date: DateTime.now(),
    ),
    Entry(
      mood: 'Sad',
      description: 'Not a great day today.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  void _addEntry() {
    setState(() {
      _entries.add(
        Entry(
          mood: 'Neutral',
          description: 'Just another day.',
          date: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _entries[index].mood,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(_entries[index].description),
                    const SizedBox(height: 8),
                    Text(
                      _entries[index].date.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgressScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen(
                themeMode: Theme.of(context).brightness == Brightness.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                onThemeChange: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                locale: Localizations.localeOf(context),
                onLocaleChange: (code) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              )),
            );
          }
        },
      ),
    );
  }
}

class Entry {
  final String mood;
  final String description;
  final DateTime date;

  Entry({
    required this.mood,
    required this.description,
    required this.date,
  });
}

class SettingsScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final Function onThemeChange;
  final Locale locale;
  final Function onLocaleChange;

  const SettingsScreen({
    Key? key,
    required this.themeMode,
    required this.onThemeChange,
    required this.locale,
    required this.onLocaleChange,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: widget.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    widget.onThemeChange();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton(
                  value: widget.locale.languageCode,
                  items: const [
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
                    widget.onLocaleChange(value);
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

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Row(
              children: [
                Text('Happy'),
                Spacer(),
                Text('80%'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Sad'),
                Spacer(),
                Text('10%'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Neutral'),
                Spacer(),
                Text('10%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}