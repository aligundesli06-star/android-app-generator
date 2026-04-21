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

  final List<String> _languages = ['English', 'Turkish', 'Spanish'];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = _isDarkMode ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo) : ThemeData.light().copyWith(primarySwatch: Colors.indigo);

    return MaterialApp(
      title: 'Habit Tracker',
      theme: theme,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [HomeScreen(), ProgressScreen(), SettingsScreen()],
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
        floatingActionButton: const AddHabitButton(),
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
      child: ListView(
        children: [
          const HabitCard(
            title: 'Exercise',
            subtitle: 'Go for a 30-minute walk',
            icon: Icons.directions_walk,
          ),
          const HabitCard(
            title: 'Meditate',
            subtitle: 'Practice mindfulness for 10 minutes',
            icon: Icons.meditation,
          ),
          const HabitCard(
            title: 'Read',
            subtitle: 'Read a book for 30 minutes',
            icon: Icons.book,
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
              const ProgressIndicator(title: 'Exercise', progress: 0.8),
              const ProgressIndicator(title: 'Meditate', progress: 0.5),
            ],
          ),
          Row(
            children: [
              const ProgressIndicator(title: 'Read', progress: 0.9),
              const ProgressIndicator(title: 'Sleep', progress: 0.7),
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
  String _language = 'English';

  final List<String> _languages = ['English', 'Turkish', 'Spanish'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              Switch(
                value: _isDarkMode,
                onChanged: (value) => setState(() => _isDarkMode = value),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                items: _languages.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _language = value as String),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const HabitCard({Key? key, required this.title, required this.subtitle, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                Text(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final String title;
  final double progress;

  const ProgressIndicator({Key? key, required this.title, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddHabitScreen(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
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
                labelText: 'Subtitle',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}