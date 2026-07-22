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
  Locale _locale = const Locale('en');

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  final List<MoodItem> _moodItems = [
    MoodItem('Happy', 'I had a great day today.', Icons.sentiment_very_satisfied, '2024-01-01'),
    MoodItem('Sad', 'I had a tough day today.', Icons.sentiment_very_dissatisfied, '2024-01-02'),
  ];

  void _addMoodItem() {
    setState(() {
      _moodItems.add(MoodItem('Neutral', 'I had a neutral day today.', Icons.sentiment_neutral, '2024-01-03'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'Mood Journal',
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
        body: [
          const HomeTab(),
          const ProgressTab(),
          SettingsTab(
            toggleDarkMode: _toggleDarkMode,
            changeLocale: _changeLocale,
            isDarkMode: _isDarkMode,
            locale: _locale,
          ),
        ][_currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: _addMoodItem,
          tooltip: 'Add Mood',
          child: const Icon(Icons.add),
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
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<MoodItem> _moodItems = [
    MoodItem('Happy', 'I had a great day today.', Icons.sentiment_very_satisfied, '2024-01-01'),
    MoodItem('Sad', 'I had a tough day today.', Icons.sentiment_very_dissatisfied, '2024-01-02'),
  ];

  void _addMoodItem() {
    setState(() {
      _moodItems.add(MoodItem('Neutral', 'I had a neutral day today.', Icons.sentiment_neutral, '2024-01-03'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _moodItems.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    _moodItems[index].icon,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _moodItems[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        _moodItems[index].description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        _moodItems[index].date,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
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

class ProgressTab extends StatelessWidget {
  const ProgressTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Center(child: Text('Progress Bar')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Center(child: Text('Progress Chart')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsTab extends StatefulWidget {
  final void Function() toggleDarkMode;
  final void Function(Locale) changeLocale;
  final bool isDarkMode;
  final Locale locale;

  const SettingsTab({
    Key? key,
    required this.toggleDarkMode,
    required this.changeLocale,
    required this.isDarkMode,
    required this.locale,
  }) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.locale,
                onChanged: (Locale? locale) {
                  widget.changeLocale(locale!);
                },
                items: [
                  DropdownMenuItem(
                    value: const Locale('en'),
                    child: const Text('English'),
                  ),
                  DropdownMenuItem(
                    value: const Locale('tr'),
                    child: const Text('Turkish'),
                  ),
                  DropdownMenuItem(
                    value: const Locale('es'),
                    child: const Text('Spanish'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoodItem {
  final String title;
  final String description;
  final IconData icon;
  final String date;

  MoodItem(this.title, this.description, this.icon, this.date);
}