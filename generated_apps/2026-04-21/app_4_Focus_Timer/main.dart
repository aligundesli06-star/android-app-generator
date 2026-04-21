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

  final List<String> _locales = ['en', 'tr', 'es'];

  void _changeLocale(String locale) {
    setState(() {
      _locale = Locale(locale);
    });
  }

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Timer',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primarySwatch: Colors.indigo,
      ),
      locale: _locale,
      home: Scaffold(
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
  bool _isStarted = false;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_workTime > 0) {
        setState(() {
          _workTime--;
        });
      } else if (_breakTime > 0) {
        setState(() {
          _breakTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
    setState(() {
      _isStarted = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isStarted = false;
    });
  }

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
                  const Icon(Icons.alarm, size: 48),
                  Text(
                    '$_workTime:00',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text('Work Time'),
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
              child: Column(
                children: [
                  const Icon(Icons.alarm_off, size: 48),
                  Text(
                    '$_breakTime:00',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text('Break Time'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isStarted ? _stopTimer : _startTimer,
            child: Text(_isStarted ? 'Stop' : 'Start'),
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
            children: const [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Work Time: 25 minutes',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Break Time: 5 minutes',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Total Sessions: 10',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Productivity: 80%',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  final List<String> _locales = ['en', 'tr', 'es'];

  void _changeLocale(String locale) {
    setState(() {
      _locale = Locale(locale);
    });
  }

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

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
                  const Text('Dark Mode'),
                  const Spacer(),
                  Switch(
                    value: _themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      if (value) {
                        _changeTheme(ThemeMode.dark);
                      } else {
                        _changeTheme(ThemeMode.light);
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
                  const Text('Language'),
                  const Spacer(),
                  DropdownButton(
                    value: _locale.languageCode,
                    items: _locales
                        .map((locale) => DropdownMenuItem(
                              child: Text(Locale(locale).languageCode),
                              value: locale,
                            ))
                        .toList(),
                    onChanged: (value) {
                      _changeLocale(value!);
                    },
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