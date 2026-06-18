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

class DynamicTheme extends StatefulWidget {
  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDarkMode = false;
  Locale? _locale;
  int _currentIndex = 0;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      switch (language) {
        case 'English':
          _locale = const Locale('en');
          break;
        case 'Turkish':
          _locale = const Locale('tr');
          break;
        case 'Spanish':
          _locale = const Locale('es');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: MyHomePage(
        toggleTheme: _toggleTheme,
        selectLanguage: _selectLanguage,
        isDarkMode: _isDarkMode,
        locale: _locale,
        currentIndex: _currentIndex,
        onChangeIndex: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final void Function(String) selectLanguage;
  final bool isDarkMode;
  final Locale? locale;
  final int currentIndex;
  final void Function(int) onChangeIndex;

  const MyHomePage({
    Key? key,
    required this.toggleTheme,
    required this.selectLanguage,
    required this.isDarkMode,
    required this.locale,
    required this.currentIndex,
    required this.onChangeIndex,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<MoodItem> _moodItems = [];

  void _addMoodItem() {
    setState(() {
      _moodItems.add(MoodItem(
        DateTime.now().toString(),
        'Happy',
        'Good day',
        Icons.smile,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            items: _moodItems,
          ),
          ProgressScreen(
            items: _moodItems,
          ),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            locale: widget.locale,
            toggleTheme: widget.toggleTheme,
            selectLanguage: widget.selectLanguage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onChangeIndex,
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
        onPressed: _addMoodItem,
        tooltip: 'Add Mood Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MoodItem {
  final String date;
  final String mood;
  final String note;
  final IconData icon;

  MoodItem(this.date, this.mood, this.note, this.icon);
}

class HomeScreen extends StatelessWidget {
  final List<MoodItem> items;

  const HomeScreen({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(item.icon),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.date,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        item.mood,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        item.note,
                        style: const TextStyle(fontSize: 14),
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

class ProgressScreen extends StatelessWidget {
  final List<MoodItem> items;

  const ProgressScreen({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: ProgressIndicator(
                  progress: 0.2,
                  label: 'Happy',
                ),
              ),
              Expanded(
                child: ProgressIndicator(
                  progress: 0.5,
                  label: 'Sad',
                ),
              ),
              Expanded(
                child: ProgressIndicator(
                  progress: 0.8,
                  label: 'Neutral',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: ProgressIndicator(
                  progress: 0.4,
                  label: 'Anxious',
                ),
              ),
              Expanded(
                child: ProgressIndicator(
                  progress: 0.6,
                  label: 'Relaxed',
                ),
              ),
              Expanded(
                child: ProgressIndicator(
                  progress: 0.2,
                  label: 'Bored',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final double progress;
  final String label;

  const ProgressIndicator({
    Key? key,
    required this.progress,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade200,
          color: Colors.indigo,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Locale? locale;
  final VoidCallback toggleTheme;
  final void Function(String) selectLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.locale,
    required this.toggleTheme,
    required this.selectLanguage,
  }) : super(key: key);

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
                value: isDarkMode,
                onChanged: (value) {
                  toggleTheme();
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
                value: locale?.languageCode ?? 'en',
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'es',
                  ),
                ],
                onChanged: (value) {
                  selectLanguage(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}