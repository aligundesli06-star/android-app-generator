```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mood Journal',
      home: JournalPage(),
    );
  }
}

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final _textController = TextEditingController();
  final _moodController = TextEditingController();
  List<JournalEntry> _journalEntries = [];
  final List<String> _moods = ['Happy', 'Sad', 'Angry', 'Neutral'];

  void _addEntry() {
    final journalEntry = JournalEntry(
      DateTime.now(),
      _textController.text,
      _moodController.text,
    );
    setState(() {
      _journalEntries.add(journalEntry);
      _textController.clear();
      _moodController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Thoughts',
                border: OutlineInputBorder(),
              ),
              minLines: 5,
              maxLines: 10,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _moodController,
              decoration: InputDecoration(
                labelText: 'Mood',
                border: const OutlineInputBorder(),
                suffixIcon: PopupMenuButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onSelected: (value) {
                    _moodController.text = value.toString();
                  },
                  itemBuilder: (context) => _moods.map((mood) {
                    return PopupMenuItem(
                      child: Text(mood),
                      value: mood,
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addEntry,
              child: const Text('Add Entry'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _journalEntries.isEmpty
                  ? const Center(child: Text('No entries yet'))
                  : ListView.builder(
                      itemCount: _journalEntries.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .format(_journalEntries[index].date),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(_journalEntries[index].thoughts),
                                const SizedBox(height: 8),
                                Text(
                                  'Mood: ${_journalEntries[index].mood}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class JournalEntry {
  final DateTime date;
  final String thoughts;
  final String mood;

  JournalEntry(this.date, this.thoughts, this.mood);
}
```