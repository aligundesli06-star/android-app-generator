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
        currentIndex: _currentIndex,
        themeMode: _themeMode,
        locale: _locale,
        changeThemeMode: _changeThemeMode,
        changeLocale: _changeLocale,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final ThemeMode themeMode;
  final Locale locale;
  final Function(ThemeMode) changeThemeMode;
  final Function(Locale) changeLocale;

  const MyHomePage({
    Key? key,
    required this.currentIndex,
    required this.themeMode,
    required this.locale,
    required this.changeThemeMode,
    required this.changeLocale,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pages = [
    const HomeScreen(),
    const ProgressScreen(),
    SettingsScreen(
      themeMode: ThemeMode.light,
      changeThemeMode: (ThemeMode themeMode) {
        widget.changeThemeMode(themeMode);
      },
      locale: const Locale('en'),
      changeLocale: (Locale locale) {
        widget.changeLocale(locale);
      },
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
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
        onPressed: () {
          // Add new item
        },
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.place, size: 48),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Destination 1', style: TextStyle(fontSize: 24)),
                      Text('Description 1'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.place, size: 48),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Destination 2', style: TextStyle(fontSize: 24)),
                      Text('Description 2'),
                    ],
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

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Progress:'),
              SizedBox(width: 16),
              CircularProgressIndicator(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Progress:'),
              SizedBox(width: 16),
              LinearProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) changeThemeMode;
  final Locale locale;
  final Function(Locale) changeLocale;

  const SettingsScreen({
    Key? key,
    required this.themeMode,
    required this.changeThemeMode,
    required this.locale,
    required this.changeLocale,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: widget.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  if (value) {
                    widget.changeThemeMode(ThemeMode.dark);
                  } else {
                    widget.changeThemeMode(ThemeMode.light);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.locale.languageCode,
                items: [
                  const DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  const DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: 'tr',
                  ),
                  const DropdownMenuItem(
                    child: Text('Español'),
                    value: 'es',
                  ),
                ],
                onChanged: (value) {
                  if (value == 'en') {
                    widget.changeLocale(const Locale('en'));
                  } else if (value == 'tr') {
                    widget.changeLocale(const Locale('tr'));
                  } else if (value == 'es') {
                    widget.changeLocale(const Locale('es'));
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