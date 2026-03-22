import 'dart:async';
import 'dart:math';
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
  String _locale = 'en';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalkBuddy',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: HomeScreen(
        currentIndex: _currentIndex,
        isDarkMode: _isDarkMode,
        locale: _locale,
        onChanged: (index) => setState(() => _currentIndex = index),
        onThemeChanged: (isDark) => setState(() => _isDarkMode = isDark),
        onLocaleChanged: (locale) => setState(() => _locale = locale),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final int currentIndex;
  final bool isDarkMode;
  final String locale;
  final Function(int) onChanged;
  final Function(bool) onThemeChanged;
  final Function(String) onLocaleChanged;

  const HomeScreen({
    Key? key,
    required this.currentIndex,
    required this.isDarkMode,
    required this.locale,
    required this.onChanged,
    required this.onThemeChanged,
    required this.onLocaleChanged,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _stepCounts = [1000, 2000, 3000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalkBuddy'),
      ),
      body: Padding(
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
                    const Icon(Icons.directions_walk),
                    const SizedBox(width: 16),
                    Text(
                      'Step Count',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(
                      _stepCounts.sum.toString(),
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
                    const Icon(Icons.bar_chart),
                    const SizedBox(width: 16),
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () =>
                          widget.onChanged(1), // Navigate to Progress screen
                      child: const Text('View'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (index) => widget.onChanged(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _stepCounts.add(Random().nextInt(1000));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.directions_walk),
                SizedBox(width: 16),
                Text('Steps'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.bar_chart),
                SizedBox(width: 16),
                Text('Distance'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final Function(String) onLocaleChanged;

  const SettingsScreen({
    Key? key,
    required this.onThemeChanged,
    required this.onLocaleChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _locale = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                      widget.onThemeChanged(value);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton(
                  value: _locale,
                  items: const [
                    DropdownMenuItem(child: Text('English'), value: 'en'),
                    DropdownMenuItem(child: Text('Türkçe'), value: 'tr'),
                    DropdownMenuItem(child: Text('Español'), value: 'es'),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _locale = value as String;
                      widget.onLocaleChanged(_locale);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}