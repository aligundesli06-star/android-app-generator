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

  final _timerController = TimerController();
  final _focusTime = FocusTime();
  final _progress = Progress();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData.light().copyWith(
              primarySwatch: Colors.indigo,
            ),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(_timerController, _focusTime),
            ProgressScreen(_progress),
            SettingsScreen(
              onDarkModeToggle: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onLanguageChange: (value) {
                setState(() {
                  _language = value;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: _language == 'English'
                  ? 'Home'
                  : _language == 'Turkish'
                      ? 'Ana Sayfa'
                      : 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: _language == 'English'
                  ? 'Progress'
                  : _language == 'Turkish'
                      ? 'İlerleme'
                      : 'Progreso',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: _language == 'English'
                  ? 'Settings'
                  : _language == 'Turkish'
                      ? 'Ayarlar'
                      : 'Configuración',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _timerController.addNewTimer();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TimerController {
  final _timers = <String>[];

  void addNewTimer() {
    _timers.add('New Timer');
  }

  List<String> get timers => _timers;
}

class FocusTime {
  final _focusTime = 25;

  int get focusTime => _focusTime;
}

class Progress {
  final _progressIndicators = <String>[];

  void addProgressIndicator() {
    _progressIndicators.add('Progress Indicator');
  }

  List<String> get progressIndicators => _progressIndicators;
}

class HomeScreen extends StatelessWidget {
  final TimerController _timerController;
  final FocusTime _focusTime;

  const HomeScreen(this._timerController, this._focusTime, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(width: 16),
                    Text(
                      'Focus Time: ${_focusTime.focusTime} minutes',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _timerController.timers.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.timer),
                          const SizedBox(width: 16),
                          Text(
                            _timerController.timers[index],
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final Progress _progress;

  const ProgressScreen(this._progress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Completed',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Not Completed',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onDarkModeToggle;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    required this.onDarkModeToggle,
    required this.onLanguageChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                const Text('Dark Mode'),
                const SizedBox(width: 16),
                Switch(
                  value: true,
                  onChanged: onDarkModeToggle,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(
                      child: Text('English'),
                      value: 'English',
                    ),
                    DropdownMenuItem(
                      child: Text('Turkish'),
                      value: 'Turkish',
                    ),
                    DropdownMenuItem(
                      child: Text('Spanish'),
                      value: 'Spanish',
                    ),
                  ],
                  onChanged: onLanguageChange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}