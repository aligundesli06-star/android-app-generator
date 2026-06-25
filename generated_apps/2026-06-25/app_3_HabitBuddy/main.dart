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
  Locale? _locale;
  List<Habit> _habits = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      theme: _isDarkMode
          ? ThemeData(brightness: Brightness.dark, primarySwatch: Colors.indigo)
          : ThemeData(primarySwatch: Colors.indigo),
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
          type: BottomNavigationBarType.fixed,
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
              _habits.add(Habit('New Habit', false));
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  String name;
  bool completed;

  Habit(this.name, this.completed);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final habits = (context as Element).findAncestorStateOfType<_MyAppState>()?._habits;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'HabitBuddy',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: habits?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(habits?[index].completed ?? false
                              ? Icons.check_circle
                              : Icons.circle),
                          const SizedBox(width: 16),
                          Text(habits?[index].name ?? ''),
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
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Progress',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Indicator(color: Colors.green, label: 'Completed'),
                SizedBox(width: 16),
                Indicator(color: Colors.red, label: 'Not Completed'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: const [
                  ProgressIndicator(color: Colors.green, value: 0.7),
                  SizedBox(height: 16),
                  ProgressIndicator(color: Colors.red, value: 0.3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String label;

  const Indicator({Key? key, required this.color, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final Color color;
  final double value;

  const ProgressIndicator({Key? key, required this.color, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey,
          color: color,
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = (context as Element).findAncestorStateOfType<_MyAppState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: state?._isDarkMode ?? false,
                  onChanged: (value) {
                    setState(() {
                      state?._isDarkMode = value;
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
                  value: state?._locale?.languageCode ?? 'en',
                  items: const [
                    DropdownMenuItem(child: Text('English'), value: 'en'),
                    DropdownMenuItem(child: Text('Türkçe'), value: 'tr'),
                    DropdownMenuItem(child: Text('Español'), value: 'es'),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value == 'en') {
                        state?._locale = const Locale('en');
                      } else if (value == 'tr') {
                        state?._locale = const Locale('tr');
                      } else if (value == 'es') {
                        state?._locale = const Locale('es');
                      }
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