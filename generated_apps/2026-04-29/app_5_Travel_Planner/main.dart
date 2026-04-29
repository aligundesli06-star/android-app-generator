import 'dart:async' show Timer;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
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
        onThemeModeChanged: (themeMode) {
          setState(() {
            _themeMode = themeMode;
          });
        },
        onLocaleChanged: (locale) {
          setState(() {
            _locale = locale;
          });
        },
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final ThemeMode themeMode;
  final Locale locale;
  final Function(ThemeMode) onThemeModeChanged;
  final Function(Locale) onLocaleChanged;
  final Function(int) onTabChanged;

  const MyHomePage({
    Key? key,
    required this.currentIndex,
    required this.themeMode,
    required this.locale,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _tabs = ['Home', 'Progress', 'Settings'];
  final List<Widget> _pages = [
    const HomeScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onTabChanged(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: _tabs[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart),
            label: _tabs[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: _tabs[2],
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  const Icon(Icons.flight, size: 24),
                  const SizedBox(width: 16),
                  const Text('Flight to New York'),
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
                  const Icon(Icons.hotel, size: 24),
                  const SizedBox(width: 16),
                  const Text('Hotel reservation'),
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
                  const Icon(Icons.restaurant, size: 24),
                  const SizedBox(width: 16),
                  const Text('Dinner at 7pm'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text('Flight'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text('Hotel reservation'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text('Dinner'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode'),
              const SizedBox(width: 8),
              Switch(
                value: _themeMode == ThemeMode.dark,
                onChanged: (value) {
                  setState(() {
                    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                  });
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        currentIndex: 2,
                        themeMode: _themeMode,
                        locale: _locale,
                        onThemeModeChanged: (themeMode) {
                          setState(() {
                            _themeMode = themeMode;
                          });
                        },
                        onLocaleChanged: (locale) {
                          setState(() {
                            _locale = locale;
                          });
                        },
                        onTabChanged: (index) {},
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _locale.languageCode,
                onChanged: (value) {
                  setState(() {
                    if (value == 'en') {
                      _locale = const Locale('en');
                    } else if (value == 'tr') {
                      _locale = const Locale('tr');
                    } else if (value == 'es') {
                      _locale = const Locale('es');
                    }
                  });
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        currentIndex: 2,
                        themeMode: _themeMode,
                        locale: _locale,
                        onThemeModeChanged: (themeMode) {
                          setState(() {
                            _themeMode = themeMode;
                          });
                        },
                        onLocaleChanged: (locale) {
                          setState(() {
                            _locale = locale;
                          });
                        },
                        onTabChanged: (index) {},
                      ),
                    ),
                  );
                },
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: 'es',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}