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

  final _localeOptions = const [
    Locale('en'),
    Locale('tr'),
    Locale('es'),
  ];

  final _titles = {
    const Locale('en'): 'Focus Timer',
    const Locale('tr'): 'Odak Zamanlayıcısı',
    const Locale('es'): 'Temporizador de Enfoque',
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _titles[_locale] ?? 'Focus Timer',
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_locale] ?? 'Focus Timer'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
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
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Add new item',
          child: Icon(Icons.add),
        ),
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
  int _workTime = 25;
  int _breakTime = 5;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_workTime > 0) {
        setState(() {
          _workTime--;
        });
      } else {
        _timer?.cancel();
        _isRunning = false;
      }
    });
    _isRunning = true;
  }

  void _stopTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Work Time: $_workTime minutes',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text('Break Time: $_breakTime minutes'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _startTimer,
            child: const Text('Start'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _stopTimer,
            child: const Text('Stop'),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.timer),
                  const SizedBox(width: 16),
                  Text(
                    _isRunning ? 'Running...' : 'Not running',
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
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: const [
                  Text('Work Time'),
                  Text('25 minutes'),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: const [
                  Text('Break Time'),
                  Text('5 minutes'),
                ],
              ),
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
  final _MyAppState? _myAppState =
      context.findAncestorStateOfType<_MyAppState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 16),
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              Switch(
                value: _myAppState?._themeMode == ThemeMode.dark,
                onChanged: (value) {
                  _myAppState?.setState(() {
                    _myAppState?._themeMode =
                        value ? ThemeMode.dark : ThemeMode.light;
                  });
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
                value: _myAppState?._locale,
                onChanged: (Locale? locale) {
                  _myAppState?.setState(() {
                    _myAppState?._locale = locale!;
                  });
                },
                items: _myAppState?._localeOptions.map((locale) {
                  return DropdownMenuItem(
                    value: locale,
                    child: Text(
                      locale.languageCode == 'en'
                          ? 'English'
                          : locale.languageCode == 'tr'
                              ? 'Türkçe'
                              : 'Español',
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}