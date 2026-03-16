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
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeRoulette',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              isDarkMode: _isDarkMode,
              language: _language,
              onLanguageChanged: (language) {
                setState(() {
                  _language = language;
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

  final List<Widget> _children = [
    const HomeScreen(),
    const ProgressScreen(),
    const Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeRoulette'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
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
          // Add new item
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: List.generate(
          6,
          (index) => Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.restaurant),
                      const SizedBox(width: 16),
                      Text(
                        'Recipe $index',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description of recipe',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
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
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              const Text('Progress'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const LinearProgressIndicator(),
              const SizedBox(width: 16),
              const Text('Linear Progress'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                const Spacer(),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.onDarkModeChanged(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton<String>(
                  value: widget.language,
                  onChanged: (value) {
                    widget.onLanguageChanged(value!);
                  },
                  items: const [
                    DropdownMenuItem(
                      child: Text('English'),
                      value: 'English',
                    ),
                    DropdownMenuItem(
                      child: Text('Turkish'),
                      value: 'Turkish',
                    ),
                    DropdownMenuItem(
                      child: Text('Spanish'),
                      value: 'Spanish',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}