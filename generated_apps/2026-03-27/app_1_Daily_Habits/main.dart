import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      child: MaterialApp(
        title: 'Daily Habits',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class DynamicTheme extends StatefulWidget {
  final Widget child;

  const DynamicTheme({super.key, required this.child});

  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeModeInheritedNotifier(
      themeMode: _themeMode,
      child: widget.child,
    );
  }
}

class ThemeModeInheritedNotifier extends InheritedNotifier<ThemeMode> {
  final ThemeMode themeMode;

  const ThemeModeInheritedNotifier({
    super.key,
    required super.child,
    required this.themeMode,
  }) : super(notifier: themeMode);

  static ThemeMode of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeModeInheritedNotifier>()!.themeMode;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Habit> _habits = [];
  final List<String> _languages = ['English', 'Turkish', 'Spanish'];
  int _selectedLanguage = 0;
  String _locale = 'English';
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    if (_isDarkMode) {
      ThemeModeInheritedNotifier.of(context).themeMode = ThemeMode.dark;
    } else {
      ThemeModeInheritedNotifier.of(context).themeMode = ThemeMode.light;
    }
  }

  void _addHabit() {
    setState(() {
      _habits.add(Habit(
        title: 'New Habit',
        description: '',
        icon: Icons.star,
        color: Colors.indigo,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              habits: _habits,
            ),
            ProgressScreen(
              habits: _habits,
            ),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              toggleDarkMode: _toggleDarkMode,
              languages: _languages,
              selectedLanguage: _selectedLanguage,
              onLanguageChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                  switch (value) {
                    case 0:
                      _locale = 'English';
                      break;
                    case 1:
                      _locale = 'Turkish';
                      break;
                    case 2:
                      _locale = 'Spanish';
                      break;
                  }
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
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
          onPressed: _addHabit,
          tooltip: 'Add Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  Habit({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    habits[index].icon,
                    color: habits[index].color,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habits[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          habits[index].description,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Habit> habits;

  const ProgressScreen({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Indicator(
                title: 'Habits',
                value: 10,
              ),
              Indicator(
                title: 'Progress',
                value: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String title;
  final int value;

  const Indicator({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        Text(
          '$value%',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function toggleDarkMode;
  final List<String> languages;
  final int selectedLanguage;
  final Function onLanguageChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Language',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton(
                value: selectedLanguage,
                items: languages.asMap().entries.map((e) {
                  return DropdownMenuItem(
                    value: e.key,
                    child: Text(e.value),
                  );
                }).toList(),
                onChanged: (value) {
                  onLanguageChanged(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}