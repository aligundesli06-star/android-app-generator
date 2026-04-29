import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const FocusTimerApp());
}

class FocusTimerApp extends StatefulWidget {
  const FocusTimerApp({Key? key}) : super(key: key);

  @override
  State<FocusTimerApp> createState() => _FocusTimerAppState();
}

class _FocusTimerAppState extends State<FocusTimerApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final _timer = Timer.periodic(const Duration(minutes: 25), (timer) {
    // Timer callback
  });

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Focus Timer'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressPage()),
                );
              },
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomePage(),
            const ProgressPage(),
            SettingsPage(
              onDarkModeChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onLanguageChanged: (value) {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddItemPage()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                children: const [
                  Icon(Icons.timer, size: 48),
                  Text('Focus Timer', style: TextStyle(fontSize: 24)),
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
                  Icon(Icons.info, size: 48),
                  Text('Description', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.check, size: 48),
              Text('Completed tasks', style: TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.access_time, size: 48),
              Text('Time spent', style: TextStyle(fontSize: 24)),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
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
              const Spacer(),
              Switch(
                value: _FocusTimerAppState().getState().isDarkMode,
                onChanged: (value) {
                  onDarkModeChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButton(
            value: _FocusTimerAppState().getState().language,
            items: const [
              DropdownMenuItem(child: Text('English'), value: 'English'),
              DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
              DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
            ],
            onChanged: (value) {
              onLanguageChanged(value as String);
            },
          ),
        ],
      ),
    );
  }
}

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Task name'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Add task'),
          ),
        ],
      ),
    );
  }
}

class _FocusTimerAppState with ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'English';

  bool get isDarkMode => _isDarkMode;

  String get language => _language;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setLanguage(String value) {
    _language = value;
    notifyListeners();
  }

  _FocusTimerAppState getState() {
    return this;
  }
}