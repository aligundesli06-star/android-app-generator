import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme();
  }
}

class DynamicTheme with ChangeNotifier {
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  bool get isDarkMode => _isDarkMode;
  Locale get locale => _locale;

  void toggleMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  ThemeData get theme => ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      );

  static const supportedLocales = [
    Locale('en'),
    Locale('tr'),
    Locale('es'),
  ];
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _habits = [
    {'name': 'Exercise', 'icon': Icons.run, 'progress': 0.8},
    {'name': 'Meditation', 'icon': Icons.meditation, 'progress': 0.5},
    {'name': 'Reading', 'icon': Icons.book, 'progress': 0.9},
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DynamicTheme(),
      builder: (context, DynamicTheme theme, child) {
        return MaterialApp(
          title: 'Habit Tracker',
          theme: theme.theme,
          locale: theme.locale,
          supportedLocales: DynamicTheme.supportedLocales,
          home: Scaffold(
            extendBody: true,
            body: IndexedStack(
              index: _currentIndex,
              children: [
                HomeScreen(habits: _habits),
                ProgressScreen(habits: _habits),
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
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add new habit
              },
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List _habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(_habits[index]['icon']),
                  const SizedBox(width: 16),
                  Text(_habits[index]['name'], style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(width: 16),
                  LinearProgressIndicator(
                    value: _habits[index]['progress'],
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
  final List _habits;

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _habits.map((habit) {
          return Row(
            children: [
              Text(habit['name']),
              const SizedBox(width: 16),
              LinearProgressIndicator(
                value: habit['progress'],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DynamicTheme(),
      builder: (context, DynamicTheme theme, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Dark Mode'),
                  const SizedBox(width: 16),
                  Switch(
                    value: theme.isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        theme.toggleMode();
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Language'),
                  const SizedBox(width: 16),
                  DropdownButton(
                    value: theme.locale,
                    items: DynamicTheme.supportedLocales.map((locale) {
                      return DropdownMenuItem(
                        child: Text(locale.languageCode == 'en' ? 'English' : locale.languageCode == 'tr' ? 'Turkish' : 'Spanish'),
                        value: locale,
                      );
                    }).toList(),
                    onChanged: (locale) {
                      setState(() {
                        theme.setLocale(locale!);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}