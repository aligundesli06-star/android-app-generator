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
      theme: _isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: const [
          MoodCard(icon: Icons.sentiment_very_satisfied, title: 'Happy', description: 'Feeling great today!'),
          MoodCard(icon: Icons.sentiment_neutral, title: 'Neutral', description: 'Feeling okay, nothing special'),
          MoodCard(icon: Icons.sentiment_very_dissatisfied, title: 'Sad', description: 'Feeling down today'),
        ],
      ),
    );
  }
}

class MoodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const MoodCard({Key? key, required this.icon, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text(description),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Indicator(title: 'Happy', value: 0.7),
              Indicator(title: 'Neutral', value: 0.2),
              Indicator(title: 'Sad', value: 0.1),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String title;
  final double value;

  const Indicator({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        Text('$value'),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: (_MyAppState.of(context)?._isDarkMode ?? false),
            onChanged: (value) {
              (_MyAppState.of(context)?._isDarkMode = value ?? false);
              (_MyAppState.of(context)?..setState(() {}));
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _MyAppState.of(context)?._language = 'English';
                  });
                },
                child: const Text('English'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _MyAppState.of(context)?._language = 'Turkish';
                  });
                },
                child: const Text('Turkish'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _MyAppState.of(context)?._language = 'Spanish';
                  });
                },
                child: const Text('Spanish'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}