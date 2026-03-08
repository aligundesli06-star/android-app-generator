import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6495ED),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Mood> _moods = [];

  void _addMood() {
    setState(() {
      _moods.insert(
        0,
        Mood(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          mood: _selectedMood,
          note: _noteController.text,
        ),
      );
      _noteController.clear();
      _selectedMood = null;
    });
  }

  final _noteController = TextEditingController();
  String? _selectedMood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedMood = 'Happy';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedMood == 'Happy'
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  child: const Text('Happy'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedMood = 'Sad';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedMood == 'Sad'
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  child: const Text('Sad'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedMood = 'Neutral';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedMood == 'Neutral'
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  child: const Text('Neutral'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _moods.isEmpty
                  ? const Center(
                      child: Text('No moods logged yet'),
                    )
                  : ListView.builder(
                      itemCount: _moods.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _moods[index].mood ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(_moods[index].note ?? ''),
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
        onPressed: _addMood,
        tooltip: 'Add Mood',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Mood {
  final String id;
  final String? mood;
  final String? note;

  Mood({required this.id, this.mood, this.note});
}