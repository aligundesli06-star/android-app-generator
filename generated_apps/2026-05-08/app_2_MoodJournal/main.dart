import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MoodJournal();
  }
}

class MoodJournal extends StatefulWidget {
  const MoodJournal({Key? key}) : super(key: key);

  @override
  State<MoodJournal> createState() => _MoodJournalState();
}

class _MoodJournalState extends State<MoodJournal> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<MoodEntry> _moodEntries = [
    MoodEntry(Mood.happy, 'I had a great day today'),
    MoodEntry(Mood.sad, 'I had a tough day today'),
    MoodEntry(Moodneutral, 'I had an average day today'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(moodEntries: _moodEntries),
            ProgressScreen(moodEntries: _moodEntries),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onChangedDarkMode: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onChangedLanguage: (value) {
                setState(() {
                  _language = value;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddMoodEntryDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void showAddMoodEntryDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _moodController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Mood Entry'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _moodController,
                  decoration: const InputDecoration(
                    labelText: 'Mood',
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _moodEntries.add(
                      MoodEntry(
                        Mood.happy,
                        _descriptionController.text,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<MoodEntry> moodEntries;

  const HomeScreen({Key? key, required this.moodEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'My Mood Entries',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: moodEntries.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            moodEntries[index].mood == Mood.happy
                                ? Icons.sentiment_very_satisfied
                                : moodEntries[index].mood == Mood.sad
                                    ? Icons.sentiment_very_dissatisfied
                                    : Icons.sentiment_neutral,
                          ),
                          title: Text(moodEntries[index].description),
                        );
                      },
                    ),
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
  final List<MoodEntry> moodEntries;

  const ProgressScreen({Key? key, required this.moodEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Happy Days: ${moodEntries.where((entry) => entry.mood == Mood.happy).length}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Icon(Icons.sentiment_very_satisfied),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Sad Days: ${moodEntries.where((entry) => entry.mood == Mood.sad).length}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Icon(Icons.sentiment_very_dissatisfied),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Neutral Days: ${moodEntries.where((entry) => entry.mood == Moodneutral).length}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Icon(Icons.sentiment_neutral),
                          ],
                        ),
                      ),
                    ],
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

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onChangedDarkMode;
  final Function(String) onChangedLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onChangedDarkMode,
    required this.onChangedLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Dark Mode: '),
                      Switch(
                        value: isDarkMode,
                        onChanged: onChangedDarkMode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Language: '),
                      DropdownButton(
                        value: language,
                        items: [
                          DropdownMenuItem(
                            child: const Text('English'),
                            value: 'English',
                          ),
                          DropdownMenuItem(
                            child: const Text('Turkish'),
                            value: 'Turkish',
                          ),
                          DropdownMenuItem(
                            child: const Text('Spanish'),
                            value: 'Spanish',
                          ),
                        ],
                        onChanged: (value) {
                          onChangedLanguage(value as String);
                        },
                      ),
                    ],
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

enum Mood { happy, sad, neutral }

class MoodEntry {
  final Mood mood;
  final String description;

  MoodEntry(this.mood, this.description);
}