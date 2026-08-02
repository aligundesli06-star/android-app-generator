import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const FocusFlow());
}

class FocusFlow extends StatefulWidget {
  const FocusFlow({Key? key}) : super(key: key);

  @override
  State<FocusFlow> createState() => _FocusFlowState();
}

class _FocusFlowState extends State<FocusFlow> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';
  List<String> _workSessions = [];
  Timer? _timer;
  int _seconds = 1500; // 25 minutes

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              workSessions: _workSessions,
              startTimer: _startTimer,
              seconds: _seconds,
            ),
            ProgressScreen(workSessions: _workSessions),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              toggleDarkMode: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              changeLanguage: (value) {
                setState(() {
                  _language = value;
                });
              },
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _workSessions.add('New Session');
            });
          },
          tooltip: 'Add New Session',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> workSessions;
  final Function startTimer;
  final int seconds;

  const HomeScreen({
    Key? key,
    required this.workSessions,
    required this.startTimer,
    required this.seconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onPressed: () => startTimer(),
            child: Text(
              'Start ${seconds / 60} minute timer',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: workSessions.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                  child: ListTile(
                    leading: const Icon(Icons.timer),
                    title: Text(workSessions[index]),
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
  final List<String> workSessions;

  const ProgressScreen({
    Key? key,
    required this.workSessions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Sessions: ${workSessions.length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: workSessions.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                  child: ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: Text(workSessions[index]),
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

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) toggleDarkMode;
  final Function(String) changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) => toggleDarkMode(value),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: ListTile(
              title: const Text('Language'),
              trailing: DropdownButton(
                value: language,
                onChanged: (value) => changeLanguage(value as String),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}