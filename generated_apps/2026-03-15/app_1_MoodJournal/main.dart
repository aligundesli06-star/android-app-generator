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
  bool _isDarkMode = false;
  String _language = 'English';
  int _currentIndex = 0;
  final List<Mood> _moods = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodJournal',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: PageController(initialPage: _currentIndex),
          children: [
            HomeScreen(
              moods: _moods,
              onAddMood: (mood) => setState(() => _moods.add(mood)),
            ),
            const ProgressScreen(),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onToggleDarkMode: (value) => setState(() => _isDarkMode = value),
              onLanguageChange: (value) => setState(() => _language = value),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Mood'),
                content: AddMoodDialog(
                  onPressed: (mood) {
                    Navigator.of(context).pop();
                    setState(() => _moods.add(mood));
                  },
                ),
              ),
            );
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Mood> moods;
  final Function(Mood) onAddMood;

  const HomeScreen({super.key, required this.moods, required this.onAddMood});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Mood Journal', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: moods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(moods[index].icon),
                          const SizedBox(width: 16),
                          Text(moods[index].description),
                        ],
                      ),
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
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Progress', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Row(
            children: const [
              ProgressIndicator(color: Colors.indigo, value: 0.5),
              SizedBox(width: 16),
              Text('50%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onToggleDarkMode;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.onToggleDarkMode,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Settings', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: onToggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: onLanguageChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddMoodDialog extends StatefulWidget {
  final Function(Mood) onPressed;

  const AddMoodDialog({super.key, required this.onPressed});

  @override
  State<AddMoodDialog> createState() => _AddMoodDialogState();
}

class _AddMoodDialogState extends State<AddMoodDialog> {
  String _description = '';
  IconData _icon = Icons.sentiment_neutral;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Description'),
          onChanged: (value) => setState(() => _description = value),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(onPressed: () => setState(() => _icon = Icons.sentiment_very_bad), icon: const Icon(Icons.sentiment_very_bad)),
            IconButton(onPressed: () => setState(() => _icon = Icons.sentiment_bad), icon: const Icon(Icons.sentiment_bad)),
            IconButton(onPressed: () => setState(() => _icon = Icons.sentiment_neutral), icon: const Icon(Icons.sentiment_neutral)),
            IconButton(onPressed: () => setState(() => _icon = Icons.sentiment_good), icon: const Icon(Icons.sentiment_good)),
            IconButton(onPressed: () => setState(() => _icon = Icons.sentiment_very_good), icon: const Icon(Icons.sentiment_very_good)),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => widget.onPressed(Mood(description: _description, icon: _icon)),
          child: const Text('Add Mood'),
        ),
      ],
    );
  }
}

class Mood {
  final String description;
  final IconData icon;

  const Mood({required this.description, required this.icon});
}