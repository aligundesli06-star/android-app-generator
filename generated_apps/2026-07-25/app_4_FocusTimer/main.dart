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

  final List<String> _workSessions = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusTimer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('tr'), Locale('es')],
      home: MyHomePage(
        workSessions: _workSessions,
        currentIndex: _currentIndex,
        themeMode: _themeMode,
        locale: _locale,
        onChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        onThemeModeChanged: (value) {
          setState(() {
            _themeMode = value;
          });
        },
        onLocaleChanged: (value) {
          setState(() {
            _locale = value;
          });
        },
        onAddSession: () {
          setState(() {
            _workSessions.add('New Session');
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<String> workSessions;
  final int currentIndex;
  final ThemeMode themeMode;
  final Locale locale;
  final void Function(int) onChanged;
  final void Function(ThemeMode) onThemeModeChanged;
  final void Function(Locale) onLocaleChanged;
  final void Function() onAddSession;

  const MyHomePage({
    Key? key,
    required this.workSessions,
    required this.currentIndex,
    required this.themeMode,
    required this.locale,
    required this.onChanged,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
    required this.onAddSession,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Timer _timer = Timer.periodic(const Duration(minutes: 25), (timer) {
    // Timer event
  });

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            workSessions: widget.workSessions,
            onAddSession: widget.onAddSession,
          ),
          ProgressScreen(),
          SettingsScreen(
            themeMode: widget.themeMode,
            locale: widget.locale,
            onThemeModeChanged: widget.onThemeModeChanged,
            onLocaleChanged: widget.onLocaleChanged,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onChanged,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddSession,
        tooltip: 'Add Session',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> workSessions;
  final void Function() onAddSession;

  const HomeScreen({
    Key? key,
    required this.workSessions,
    required this.onAddSession,
  }) : super(key: key);

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
              child: Column(
                children: [
                  const Icon(
                    Icons.timer,
                    size: 40,
                  ),
                  Text(
                    'Focus Time',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text('25 minutes'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: workSessions.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      workSessions[index],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check,
                        size: 40,
                      ),
                      Text(
                        'Completed Sessions',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Text('10'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 40,
                      ),
                      Text(
                        'Total Focus Time',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Text('250 minutes'),
                    ],
                  ),
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
  final ThemeMode themeMode;
  final Locale locale;
  final void Function(ThemeMode) onThemeModeChanged;
  final void Function(Locale) onLocaleChanged;

  const SettingsScreen({
    Key? key,
    required this.themeMode,
    required this.locale,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
  }) : super(key: key);

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
                  const Icon(
                    Icons.brightness_4,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Theme',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Switch(
                    value: themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      if (value) {
                        onThemeModeChanged(ThemeMode.dark);
                      } else {
                        onThemeModeChanged(ThemeMode.light);
                      }
                    },
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
                  const Icon(
                    Icons.language,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: locale.languageCode,
                    onChanged: (value) {
                      if (value == 'en') {
                        onLocaleChanged(const Locale('en'));
                      } else if (value == 'tr') {
                        onLocaleChanged(const Locale('tr'));
                      } else if (value == 'es') {
                        onLocaleChanged(const Locale('es'));
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        child: const Text('English'),
                        value: 'en',
                      ),
                      DropdownMenuItem(
                        child: const Text('Türkçe'),
                        value: 'tr',
                      ),
                      DropdownMenuItem(
                        child: const Text('Español'),
                        value: 'es',
                      ),
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