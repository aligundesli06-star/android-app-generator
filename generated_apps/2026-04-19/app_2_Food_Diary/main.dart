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
  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('en');
  int _currentIndex = 0;
  List<String> foods = [];

  void _addFood() {
    setState(() {
      foods.add('New Food Item ${foods.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Food Diary'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addFood,
          tooltip: 'Add Food',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _foods = [
    'Breakfast',
    'Lunch',
    'Dinner',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(Icons.fastfood, size: 40),
                  SizedBox(height: 16),
                  Text('Food Diary', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _foods.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.restaurant, size: 24),
                        const SizedBox(width: 16),
                        Text(_foods[index]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Calories', style: TextStyle(fontSize: 20)),
                    const Text('1200', style: TextStyle(fontSize: 40)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    const Text('Carbs', style: TextStyle(fontSize: 20)),
                    const Text('200', style: TextStyle(fontSize: 40)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Protein', style: TextStyle(fontSize: 20)),
                    const Text('50', style: TextStyle(fontSize: 40)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    const Text('Fat', style: TextStyle(fontSize: 20)),
                    const Text('20', style: TextStyle(fontSize: 40)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'en';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
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
                    if (_isDarkMode) {
                      context.findAncestorStateOfType<_MyAppState>()!.themeMode = ThemeMode.dark;
                    } else {
                      context.findAncestorStateOfType<_MyAppState>()!.themeMode = ThemeMode.light;
                    }
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
                onChanged: (String? value) {
                  setState(() {
                    _language = value!;
                    if (_language == 'en') {
                      context.findAncestorStateOfType<_MyAppState>()!.locale = const Locale('en');
                    } else if (_language == 'tr') {
                      context.findAncestorStateOfType<_MyAppState>()!.locale = const Locale('tr');
                    } else {
                      context.findAncestorStateOfType<_MyAppState>()!.locale = const Locale('es');
                    }
                  });
                },
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'en'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'tr'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'es'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}