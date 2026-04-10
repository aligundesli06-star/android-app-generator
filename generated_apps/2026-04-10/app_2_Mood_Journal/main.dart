import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDark = false;
  String _language = 'English';

  final _moods = [
    {'mood': 'Happy', 'icon': Icons.sentiment_very_satisfied, 'color': Colors.green},
    {'mood': 'Sad', 'icon': Icons.sentiment_very_dissatisfied, 'color': Colors.red},
    {'mood': 'Neutral', 'icon': Icons.sentiment_neutral, 'color': Colors.grey},
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            moods: _moods,
            isDark: _isDark,
            language: _language,
          ),
          ProgressScreen(
            isDark: _isDark,
            language: _language,
          ),
          SettingsScreen(
            isDark: _isDark,
            language: _language,
            onDarkModeToggle: _toggleDarkMode,
            onLanguageChange: _changeLanguage,
          ),
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
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: _language == 'English' ? 'Home' : _language == 'Turkish' ? 'Ana Sayfa' : 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart),
            label: _language == 'English' ? 'Progress' : _language == 'Turkish' ? 'İlerleme' : 'Progreso',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: _language == 'English' ? 'Settings' : _language == 'Turkish' ? 'Ayarlar' : 'Configuración',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item logic
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List _moods;
  final bool _isDark;
  final String _language;

  const HomeScreen({
    Key? key,
    required List moods,
    required bool isDark,
    required String language,
  })  : _moods = moods,
        _isDark = isDark,
        _language = language,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _language == 'English' ? 'Welcome to Mood Journal' : _language == 'Turkish' ? 'Mood Journal\'a Hoş Geldiniz' : 'Bienvenido a Mood Journal',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _moods.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _moods[index]['icon'],
                            color: _moods[index]['color'],
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _moods[index]['mood'],
                            style: const TextStyle(fontSize: 18),
                          ),
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
  final bool _isDark;
  final String _language;

  const ProgressScreen({
    Key? key,
    required bool isDark,
    required String language,
  })  : _isDark = isDark,
        _language = language,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _language == 'English' ? 'Your Progress' : _language == 'Turkish' ? 'İlerlemeniz' : 'Tu Progreso',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.sentiment_very_satisfied,
                            size: 48,
                          ),
                          const Text('Happy'),
                          const Text('50%'),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.sentiment_neutral,
                            size: 48,
                          ),
                          const Text('Neutral'),
                          const Text('30%'),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.sentiment_very_dissatisfied,
                            size: 48,
                          ),
                          const Text('Sad'),
                          const Text('20%'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool _isDark;
  final String _language;
  final Function _onDarkModeToggle;
  final Function _onLanguageChange;

  const SettingsScreen({
    Key? key,
    required bool isDark,
    required String language,
    required Function onDarkModeToggle,
    required Function onLanguageChange,
  })  : _isDark = isDark,
        _language = language,
        _onDarkModeToggle = onDarkModeToggle,
        _onLanguageChange = onLanguageChange,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _language == 'English' ? 'Settings' : _language == 'Turkish' ? 'Ayarlar' : 'Configuración',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Dark Mode'),
                      const SizedBox(width: 16),
                      Switch(
                        value: _isDark,
                        onChanged: (value) {
                          _onDarkModeToggle();
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
                        value: _language,
                        onChanged: (value) {
                          _onLanguageChange(value);
                        },
                        items: [
                          DropdownMenuItem(
                            child: const Text('English'),
                            value: 'English',
                          ),
                          DropdownMenuItem(
                            child: const Text('Türkçe'),
                            value: 'Turkish',
                          ),
                          DropdownMenuItem(
                            child: const Text('Español'),
                            value: 'Spanish',
                          ),
                        ],