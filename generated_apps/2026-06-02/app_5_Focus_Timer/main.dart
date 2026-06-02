import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late ThemeMode _themeMode;
  late Locale _locale;
  late Timer _timer;
  int _workMinutes = 25;
  int _breakMinutes = 5;
  bool _isRunning = false;
  int _remainingTime = 0;

  @override
  void initState() {
    super.initState();
    _themeMode = ThemeMode.light;
    _locale = const Locale('en');
    _remainingTime = _workMinutes * 60;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      child: MaterialApp(
        locale: _locale,
        themeMode: _themeMode,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Focus Timer'),
            actions: [
              IconButton(
                icon: const Icon(Icons.bar_chart),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              HomeScreen(
                workMinutes: _workMinutes,
                breakMinutes: _breakMinutes,
                remainingTime: _remainingTime,
                isRunning: _isRunning,
                onTimerStart: () {
                  _startTimer();
                },
                onTimerStop: () {
                  _stopTimer();
                },
              ),
              ProgressScreen(),
              SettingsScreen(
                themeMode: _themeMode,
                locale: _locale,
                onThemeModeChanged: (ThemeMode themeMode) {
                  setState(() {
                    _themeMode = themeMode;
                  });
                },
                onLocaleChanged: (Locale locale) {
                  setState(() {
                    _locale = locale;
                  });
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Add new item'),
                          const TextField(),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            tooltip: 'Add item',
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
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
        ),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _remainingTime = _breakMinutes * 60;
          _isRunning = false;
          timer.cancel();
        }
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }
}

class HomeScreen extends StatelessWidget {
  final int workMinutes;
  final int breakMinutes;
  final int remainingTime;
  final bool isRunning;
  final VoidCallback onTimerStart;
  final VoidCallback onTimerStop;

  const HomeScreen({
    Key? key,
    required this.workMinutes,
    required this.breakMinutes,
    required this.remainingTime,
    required this.isRunning,
    required this.onTimerStart,
    required this.onTimerStop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
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
                    '${workMinutes} minutes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.pause),
                  const SizedBox(width: 16),
                  Text(
                    '${breakMinutes} minutes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$remainingTime seconds remaining',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: isRunning ? onTimerStop : onTimerStart,
            child: Text(isRunning ? 'Stop' : 'Start'),
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
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Work sessions: 0',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Break sessions: 0',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Time spent working: 0 minutes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Time spent breaking: 0 minutes',
                    style: Theme.of(context).textTheme.titleLarge,
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
  final VoidCallback onThemeModeChanged;
  final VoidCallback onLocaleChanged;

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
          Row(
            children: [
              const Text('Dark mode'),
              const SizedBox(width: 16),
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
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: locale,
                items: [
                  const DropdownMenuItem(
                    child: Text('English'),
                    value: Locale('en'),
                  ),
                  const DropdownMenuItem(
                    child: Text('Turkish'),
                    value: Locale('tr'),
                  ),
                  const DropdownMenuItem(
                    child: Text('Spanish'),
                    value: Locale('es'),
                  ),
                ],
                onChanged: (Locale? value) {
                  onLocaleChanged(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}