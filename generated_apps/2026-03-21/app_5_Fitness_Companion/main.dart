import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Companion',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fitness Companion'),
        ),
        body: _currentIndex == 0
            ? HomeScreen(_isDarkMode, _language)
            : _currentIndex == 1
                ? ProgressScreen(_isDarkMode, _language)
                : SettingsScreen(
                    isDarkMode: _isDarkMode,
                    language: _language,
                    onLanguageChange: (language) {
                      setState(() {
                        _language = language;
                      });
                    },
                    onThemeChange: (isDarkMode) {
                      setState(() {
                        _isDarkMode = isDarkMode;
                      });
                    },
                  ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
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
          onPressed: () {
            // Add new item
          },
          tooltip: 'Add new item',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool _isDarkMode;
  final String _language;

  const HomeScreen(this._isDarkMode, this._language, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.directions_run),
                  const SizedBox(width: 16),
                  Text(
                    _language == 'English'
                        ? 'Workout Plan'
                        : _language == 'Turkish'
                            ? 'Egzersiz Planı'
                            : 'Plan de Entrenamiento',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.restaurant),
                  const SizedBox(width: 16),
                  Text(
                    _language == 'English'
                        ? 'Nutrition Advice'
                        : _language == 'Turkish'
                            ? 'Beslenme Danışmanlık'
                            : 'Asesoramiento Nutricional',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final bool _isDarkMode;
  final String _language;

  const ProgressScreen(this._isDarkMode, this._language, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _language == 'English'
                            ? 'Steps'
                            : _language == 'Turkish'
                                ? 'Adımlar'
                                : 'Pasos',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1000',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _language == 'English'
                            ? 'Distance'
                            : _language == 'Turkish'
                                ? 'Mesafe'
                                : 'Distancia',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '5 km',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    _language == 'English'
                        ? 'Calories Burned'
                        : _language == 'Turkish'
                            ? 'Yakılan Kaloriler'
                            : 'Calorías Quemadas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '500',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onThemeChange;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.onThemeChange,
    required this.onLanguageChange,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = '';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _language = widget.language;
  }

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
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    widget.onThemeChange(value);
                  });
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
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                    widget.onLanguageChange(value as String);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}