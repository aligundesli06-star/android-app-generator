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
  late ThemeData _themeData;
  late Locale _locale;
  int _selectedTabIndex = 0;
  bool _isDarkMode = false;
  String _languageCode = 'en';

  List<String> _habits = [];

  @override
  void initState() {
    super.initState();
    _themeData = ThemeData(primarySwatch: Colors.indigo);
    _locale = const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      theme: _themeData,
      darkTheme: _themeData.copyWith(
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _selectedTabIndex,
          children: [
            HomeScreen(
              habits: _habits,
              onAddHabit: (String habit) {
                setState(() {
                  _habits.add(habit);
                });
              },
            ),
            ProgressScreen(habits: _habits),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              onToggleDarkMode: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              languageCode: _languageCode,
              onLanguageChange: (String languageCode) {
                setState(() {
                  _languageCode = languageCode;
                  _locale = Locale(languageCode);
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: (int index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final String newHabit = 'New Habit ${_habits.length + 1}';
            setState(() {
              _habits.add(newHabit);
            });
          },
          tooltip: 'Add Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> habits;
  final void Function(String) onAddHabit;

  const HomeScreen({
    Key? key,
    required this.habits,
    required this.onAddHabit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ...habits.map((String habit) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_box),
                    const SizedBox(width: 16.0),
                    Text(
                      habit,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<String> habits;

  const ProgressScreen({
    Key? key,
    required this.habits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16.0),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          ...habits.map((String habit) {
            return Row(
              children: [
                Text(habit),
                const SizedBox(width: 16.0),
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final void Function(bool) onToggleDarkMode;
  final String languageCode;
  final void Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.languageCode,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.toggle_on),
              const SizedBox(width: 16.0),
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: widget.isDarkMode,
                onChanged: widget.onToggleDarkMode,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16.0),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButton(
                value: widget.languageCode,
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: const Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'tr',
                    child: const Text('Turkish'),
                  ),
                  DropdownMenuItem(
                    value: 'es',
                    child: const Text('Spanish'),
                  ),
                ],
                onChanged: widget.onLanguageChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}