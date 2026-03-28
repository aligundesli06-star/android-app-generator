import 'package:flutter/material.dart';
import 'dart:async';

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

  void _changeThemeMode() {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitTracker',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      locale: _locale,
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              themeMode: _themeMode,
              locale: _locale,
              onChangeThemeMode: _changeThemeMode,
              onChangeLocale: _changeLocale,
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _habitCards = [
    HabitCard(
      title: 'Exercise',
      description: '30 minutes of exercise per day',
      icon: Icons.directions_run,
    ),
    HabitCard(
      title: 'Reading',
      description: 'Read for 1 hour per day',
      icon: Icons.book,
    ),
  ];

  void _addHabit() {
    setState(() {
      _habitCards.add(
        HabitCard(
          title: 'New Habit',
          description: '',
          icon: Icons.add,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitTracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _habitCards.map((habitCard) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      habitCard.icon,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habitCard.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          habitCard.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => index == 0
                ? const MyHomePage()
                : index == 1
                    ? const ProgressPage()
                    : const SettingsPage(
                        themeMode: ThemeMode.light,
                        locale: Locale('en'),
                        onChangeThemeMode: null,
                        onChangeLocale: null,
                      ),
          ),
        ),
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

class HabitCard {
  final String title;
  final String description;
  final IconData icon;

  HabitCard({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Progress'),
                const SizedBox(width: 16),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Achievements'),
                const SizedBox(width: 16),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final ThemeMode themeMode;
  final Locale locale;
  final VoidCallback? onChangeThemeMode;
  final Function(String)? onChangeLocale;

  const SettingsPage({
    Key? key,
    required this.themeMode,
    required this.locale,
    this.onChangeThemeMode,
    this.onChangeLocale,
  }) : super(key: key);

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
                const Text('Theme'),
                const SizedBox(width: 16),
                themeMode == ThemeMode.light
                    ? const Text('Light')
                    : const Text('Dark'),
                const Spacer(),
                Switch(
                  value: themeMode == ThemeMode.light,
                  onChanged: (value) => onChangeThemeMode?.call(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const SizedBox(width: 16),
                DropdownButton(
                  value: locale.languageCode,
                  onChanged: (value) => onChangeLocale?.call(value.toString()),
                  items: [
                    const DropdownMenuItem(
                      child: Text('English'),
                      value: 'en',
                    ),
                    const DropdownMenuItem(
                      child: Text('Turkish'),
                      value: 'tr',
                    ),
                    const DropdownMenuItem(
                      child: Text('Spanish'),
                      value: 'es',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}