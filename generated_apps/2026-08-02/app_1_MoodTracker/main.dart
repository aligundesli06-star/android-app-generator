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
  String _locale = 'en';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      locale: Locale(_locale),
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              onLocaleChanged: (locale) {
                setState(() {
                  _locale = locale;
                });
              },
              onDarkModeChanged: (isDarkMode) {
                setState(() {
                  _isDarkMode = isDarkMode;
                });
              },
            ),
      },
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
  final _moodles = [
    {'name': 'Happy', 'color': Colors.yellow, 'icon': Icons.sentiment_very_satisfied},
    {'name': 'Sad', 'color': Colors.blue, 'icon': Icons.sentiment_dissatisfied},
    {'name': 'Angry', 'color': Colors.red, 'icon': Icons.sentiment_very_dissatisfied},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(moodles: _moodles),
          ProgressScreen(),
          Container(), // placeholder for settings
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
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
          // add new item
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> moodles;

  const HomeScreen({Key? key, required this.moodles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: moodles
            .map((moodle) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: moodle['color'],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            moodle['icon'],
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            moodle['name'],
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: Indicator(
                  label: 'Happy',
                  value: 0.4,
                  color: Colors.yellow,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Indicator(
                  label: 'Sad',
                  value: 0.3,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: Indicator(
                  label: 'Angry',
                  value: 0.2,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Indicator(
                  label: 'Neutral',
                  value: 0.1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const Indicator({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade200,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class SettingsPage extends StatefulWidget {
  final Function(String) onLocaleChanged;
  final Function(bool) onDarkModeChanged;

  const SettingsPage({
    Key? key,
    required this.onLocaleChanged,
    required this.onDarkModeChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                const SizedBox(width: 16),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                      widget.onDarkModeChanged(value);
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
                  value: _locale,
                  items: [
                    DropdownMenuItem(
                      child: const Text('English'),
                      value: 'en',
                    ),
                    DropdownMenuItem(
                      child: const Text('Türkçe'),
                      value: 'tr',
                    ),
                    DropdownMenuItem(
                      child: const Text('Español'),
                      value: 'es',
                    ),
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