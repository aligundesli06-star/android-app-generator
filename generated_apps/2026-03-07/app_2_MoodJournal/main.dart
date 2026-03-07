import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodJournal',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MoodEntry> _moodEntries = [];
  final _moodEntryController = TextEditingController();

  void _addMoodEntry() {
    if (_moodEntryController.text.isNotEmpty) {
      setState(() {
        _moodEntries.add(
          MoodEntry(
            mood: _moodEntryController.text,
            date: DateTime.now(),
          ),
        );
        _moodEntryController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodJournal'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _moodEntryController,
              decoration: InputDecoration(
                labelText: 'How are you feeling today?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addMoodEntry,
              child: const Text('Add Entry'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _moodEntries.isEmpty
                  ? const Center(
                      child: Text('No entries yet'),
                    )
                  : ListView.builder(
                      itemCount: _moodEntries.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _moodEntries[index].mood,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  DateFormat.yMMMMd().format(_moodEntries[index].date),
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addMoodEntry,
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MoodEntry {
  final String mood;
  final DateTime date;

  MoodEntry({required this.mood, required this.date});
}