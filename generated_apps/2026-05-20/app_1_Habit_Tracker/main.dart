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
  List<Habit> habits = [];
  bool isDarkMode = false;
  String language = 'English';

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void _changeLanguage(String lang) {
    setState(() {
      language = lang;
    });
  }

  void _addHabit() {
    setState(() {
      habits.add(Habit(title: 'New Habit', isDone: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habits: habits, language: language),
            ProgressScreen(habits: habits),
            SettingsScreen(
              isDarkMode: isDarkMode,
              language: language,
              onToggleDarkMode: _toggleDarkMode,
              onChangeLanguage: _changeLanguage,
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
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: language == 'English'
                  ? 'Home'
                  : language == 'Turkish'
                      ? 'Ana Sayfa'
                      : 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: language == 'English'
                  ? 'Progress'
                  : language == 'Turkish'
                      ? 'İlerleme'
                      : 'Progreso',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: language == 'English'
                  ? 'Settings'
                  : language == 'Turkish'
                      ? 'Ayarlar'
                      : 'Configuración',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addHabit,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String title;
  final bool isDone;

  Habit({required this.title, required this.isDone});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final String language;

  const HomeScreen({Key? key, required this.habits, required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: habits
            .map(
              (habit) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        habit.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        habit.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Habit> habits;

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.check_box),
              const SizedBox(width: 16),
              Text(
                '${habits.where((habit) => habit.isDone).length}/${habits.length}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${habits.where((habit) => habit.isDone).length} Done',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${habits.where((habit) => !habit.isDone).length} Pending',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
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
  final void Function() onToggleDarkMode;
  final void Function(String) onChangeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onToggleDarkMode,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.toggle_off),
              const SizedBox(width: 16),
              Text(
                isDarkMode ? 'Light Mode' : 'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onToggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButton(
                value: language,
                items: [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Español'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (String? value) {
                  if (value != null) {
                    onChangeLanguage(value);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}