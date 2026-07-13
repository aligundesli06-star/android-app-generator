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
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusTimer',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData(primarySwatch: Colors.indigo),
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
          onTap: (index) => setState(() => _currentIndex = index),
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
  Timer? _timer;
  int _seconds = 25 * 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(_seconds),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _startTimer,
                    child: const Text('Start'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pauseTimer,
                    child: const Text('Pause'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Text('Focus on your work'),
                  SizedBox(height: 16),
                  Text('Take breaks to refresh your mind'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor().toString().padLeft(2, '0');
    final secondsDisplay = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secondsDisplay';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
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
              Icon(Icons.bar_chart),
              SizedBox(width: 8),
              Text('Today\'s progress'),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Text('Completed tasks: 5'),
                  SizedBox(height: 8),
                  Text('Time spent: 2h 30m'),
                ],
              ),
            ),
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
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 8),
              Text(
                _language == 'English' ? 'Settings' : _language == 'Turkish' ? 'Ayarlar' : 'Configuración',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Dark mode'),
                      const Spacer(),
                      Switch(
                        value: _isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _isDarkMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Language'),
                      const Spacer(),
                      DropdownButton(
                        value: _language,
                        items: const [
                          DropdownMenuItem(child: Text('English'), value: 'English'),
                          DropdownMenuItem(child: Text('Türkçe'), value: 'Turkish'),
                          DropdownMenuItem(child: Text('Español'), value: 'Spanish'),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _language = value as String;
                          });
                        },
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