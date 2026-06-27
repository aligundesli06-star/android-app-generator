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

  void _changeThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
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
      title: 'MoodTracker',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      locale: _locale,
      home: HomeScreen(
        onAddItem: () {
          // Add new item logic
        },
        onChangeThemeMode: _changeThemeMode,
        onChangeLocale: _changeLocale,
        themeMode: _themeMode,
        locale: _locale,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onAddItem;
  final ValueChanged<ThemeMode> onChangeThemeMode;
  final ValueChanged<Locale> onChangeLocale;
  final ThemeMode themeMode;
  final Locale locale;

  const HomeScreen({
    super.key,
    required this.onAddItem,
    required this.onChangeThemeMode,
    required this.onChangeLocale,
    required this.themeMode,
    required this.locale,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeTab(onAddItem: widget.onAddItem),
          ProgressTab(),
          SettingsTab(
            onChangeThemeMode: widget.onChangeThemeMode,
            onChangeLocale: widget.onChangeLocale,
            themeMode: widget.themeMode,
            locale: widget.locale,
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddItem,
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final VoidCallback onAddItem;

  const HomeTab({super.key, required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.sentiment_very_satisfied),
                  const SizedBox(width: 16),
                  Text(
                    'Good',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.sentiment_neutral),
                  const SizedBox(width: 16),
                  Text(
                    'Neutral',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.sentiment_very_dissatisfied),
                  const SizedBox(width: 16),
                  Text(
                    'Bad',
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

class ProgressTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Good',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              Text(
                '50%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Neutral',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              Text(
                '30%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Bad',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              Text(
                '20%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  final ValueChanged<ThemeMode> onChangeThemeMode;
  final ValueChanged<Locale> onChangeLocale;
  final ThemeMode themeMode;
  final Locale locale;

  const SettingsTab({
    super.key,
    required this.onChangeThemeMode,
    required this.onChangeLocale,
    required this.themeMode,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  onChangeThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
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
                    onChangeLocale(const Locale('en'));
                  } else if (value == 'tr') {
                    onChangeLocale(const Locale('tr'));
                  } else if (value == 'es') {
                    onChangeLocale(const Locale('es'));
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