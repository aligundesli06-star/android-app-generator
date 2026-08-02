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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeHub',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
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
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle adding new item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddItemScreen()),
            );
          },
          tooltip: 'Add new item',
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        children: const [
          RecipeCard(
            title: 'Spaghetti Bolognese',
            subtitle: 'Italian dish with pasta and meat sauce',
          ),
          RecipeCard(
            title: 'Chicken Curry',
            subtitle: 'Indian dish with chicken and curry sauce',
          ),
          RecipeCard(
            title: 'Grilled Salmon',
            subtitle: 'Seafood dish with grilled salmon and vegetables',
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const RecipeCard({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.restaurant),
                const SizedBox(width: 16),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            Text(subtitle, style: Theme.of(context).textTheme.bodyText1),
          ],
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
        children: const [
          ProgressIndicatorRow(
            title: 'Calories',
            value: 2000,
            total: 3000,
          ),
          ProgressIndicatorRow(
            title: 'Water',
            value: 1500,
            total: 2000,
          ),
          ProgressIndicatorRow(
            title: 'Exercise',
            value: 60,
            total: 90,
          ),
        ],
      ),
    );
  }
}

class ProgressIndicatorRow extends StatelessWidget {
  final String title;
  final int value;
  final int total;

  const ProgressIndicatorRow(
      {Key? key, required this.title, required this.value, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(width: 16),
        Expanded(
          child: LinearProgressIndicator(
            value: value / total,
          ),
        ),
        const SizedBox(width: 16),
        Text('$value/$total', style: Theme.of(context).textTheme.bodyText1),
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
                  });
                  MyApp._MyAppState().setState(() {
                    MyApp._MyAppState()._isDarkMode = value;
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
              DropdownButton<String>(
                value: _language,
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
                onChanged: (value) {
                  setState(() {
                    _language = value!;
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

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}