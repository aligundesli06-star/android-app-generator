```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MoodTracker());
}

class MoodTracker extends StatelessWidget {
  const MoodTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MoodTracker',
      home: MoodTrackerHome(),
    );
  }
}

class MoodTrackerHome extends StatefulWidget {
  const MoodTrackerHome({Key? key}) : super(key: key);

  @override
  State<MoodTrackerHome> createState() => _MoodTrackerHomeState();
}

class _MoodTrackerHomeState extends State<MoodTrackerHome> {
  final List<Mood> _moods = [
    Mood('Happy', Colors.green),
    Mood('Sad', Colors.blue),
    Mood('Anxious', Colors.red),
    Mood('Angry', Colors.orange),
    Mood('Neutral', Colors.grey),
  ];
  Mood? _selectedMood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodTracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _selectedMood != null
                  ? 'Your current mood is: ${_selectedMood?.name}'
                  : 'Select your current mood',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              itemCount: _moods.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMood = _moods[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _moods[index].color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _moods[index].name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _selectedMood != null
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Mood Insights'),
                            content: Text(
                              'You have selected ${_selectedMood?.name}. Did you know that regular exercise and meditation can help improve your mood?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null,
              child: const Text('Get Insights'),
            ),
          ),
        ],
      ),
    );
  }
}

class Mood {
  final String name;
  final Color color;

  const Mood(this.name, this.color);
}
```