```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MoodTrackerHomePage(),
    );
  }
}

class MoodTrackerHomePage extends StatefulWidget {
  const MoodTrackerHomePage({Key? key}) : super(key: key);

  @override
  State<MoodTrackerHomePage> createState() => _MoodTrackerHomePageState();
}

class _MoodTrackerHomePageState extends State<MoodTrackerHomePage> {
  String? _mood;
  final _moodController = TextEditingController();
  final List<MoodEntry> _moodEntries = [];

  void _addMoodEntry() {
    if (_moodController.text.isNotEmpty) {
      setState(() {
        _moodEntries.add(MoodEntry(_moodController.text));
        _moodController.clear();
      });
    }
  }

  void _showMoodDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('How are you feeling today?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Select an emotion:'),
              ListTile(
                title: Text('Happy'),
                tileColor: Colors.green,
              ),
              ListTile(
                title: Text('Sad'),
                tileColor: Colors.blue,
              ),
              ListTile(
                title: Text('Angry'),
                tileColor: Colors.red,
              ),
              ListTile(
                title: Text('Other'),
                tileColor: Colors.grey,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _mood = 'Happy';
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodTracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showMoodDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _moodController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'How are you feeling today?',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addMoodEntry,
            child: const Text('Add Mood Entry'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _moodEntries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_moodEntries[index].mood),
                  trailing: const Icon(Icons.sentiment_satisfied),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MoodEntry {
  final String mood;

  MoodEntry(this.mood);
}
```