import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MyApp());

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
      title: 'MoodJournal',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: MyHomePage(
        currentIndex: _currentIndex,
        isDarkMode: _isDarkMode,
        language: _language,
        onChanged: (index) => setState(() => _currentIndex = index),
        onDarkModeChanged: (mode) => setState(() => _isDarkMode = mode),
        onLanguageChanged: (lang) => setState(() => _language = lang),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final bool isDarkMode;
  final String language;
  final Function(int) onChanged;
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const MyHomePage({
    Key? key,
    required this.currentIndex,
    required this.isDarkMode,
    required this.language,
    required this.onChanged,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Mood> _moods = [
    Mood('Happiness', Icons.smile, 'I am feeling happy today'),
    Mood('Sadness', Icons.sentiment_dissatisfied, 'I am feeling sad today'),
    Mood('Anger', Icons.sentiment_very_dissatisfied, 'I am feeling angry today'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: const [
          HomeScreen(),
          ProgressScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) => widget.onChanged(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddMoodDialog(
              onAdded: (mood) => setState(() => _moods.add(mood)),
            ),
          );
        },
        tooltip: 'Add new mood',
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
      child: ListView.builder(
        itemCount: _moods.length,
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
                  Icon(_moods[index].icon, size: 48),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_moods[index].title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(_moods[index].description),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
            children: const [
              Text('Happiness:'),
              SizedBox(width: 16),
              Text('50%'),
            ],
          ),
          Row(
            children: const [
              Text('Sadness:'),
              SizedBox(width: 16),
              Text('20%'),
            ],
          ),
          Row(
            children: const [
              Text('Anger:'),
              SizedBox(width: 16),
              Text('30%'),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (mode) {
                  setState(() => _isDarkMode = mode);
                  (context as Element).widget.onChanged!(mode);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                onChanged: (lang) {
                  setState(() => _language = lang as String);
                  (context as Element).widget.onChanged!(lang);
                },
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddMoodDialog extends StatefulWidget {
  final Function(Mood) onAdded;

  const AddMoodDialog({Key? key, required this.onAdded}) : super(key: key);

  @override
  State<AddMoodDialog> createState() => _AddMoodDialogState();
}

class _AddMoodDialogState extends State<AddMoodDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  IconData? _icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.smile),
                  onPressed: () => setState(() => _icon = Icons.smile),
                ),
                IconButton(
                  icon: const Icon(Icons.sentiment_dissatisfied),
                  onPressed: () => setState(() => _icon = Icons.sentiment_dissatisfied),
                ),
                IconButton(
                  icon: const Icon(Icons.sentiment_very_dissatisfied),
                  onPressed: () => setState(() => _icon = Icons.sentiment_very_dissatisfied),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onAdded(Mood(
                  _titleController.text,
                  _icon ?? Icons.smile,
                  _descriptionController.text,
                ));
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

class Mood {
  final String title;
  final IconData icon;
  final String description;

  Mood(this.title, this.icon, this.description);
}