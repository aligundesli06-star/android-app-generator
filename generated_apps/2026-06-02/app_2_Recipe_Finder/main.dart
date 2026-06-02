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
  String _language = 'English';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Finder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
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
              icon: Icon(Icons.show_chart),
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  'assets/chicken.jpg',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Chicken Recipe',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('Prep Time: 30 minutes'),
                  ],
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  'assets/fish.jpg',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Fish Recipe',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('Prep Time: 20 minutes'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Column(
              children: [
                Text(
                  'Calories',
                  style: TextStyle(fontSize: 16),
                ),
                Text('2000'),
              ],
            ),
            Column(
              children: [
                Text(
                  'Protein',
                  style: TextStyle(fontSize: 16),
                ),
                Text('100g'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Column(
              children: [
                Text(
                  'Fat',
                  style: TextStyle(fontSize: 16),
                ),
                Text('50g'),
              ],
            ),
            Column(
              children: [
                Text(
                  'Carbs',
                  style: TextStyle(fontSize: 16),
                ),
                Text('200g'),
              ],
            ),
          ],
        ),
      ],
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
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                    _language = value ?? 'English';
                  });
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NutritionDetailsScreen(),
                ),
              );
            },
            child: const Text('Nutrition Details'),
          ),
        ],
      ),
    );
  }
}

class NutritionDetailsScreen extends StatelessWidget {
  const NutritionDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Nutrition Details',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Calories',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text('2000'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Protein',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text('100g'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Fat',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text('50g'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Carbs',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Text('200g'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}