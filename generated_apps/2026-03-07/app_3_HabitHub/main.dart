```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const HabitHubApp());
}

class HabitHubApp extends StatelessWidget {
  const HabitHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HabitHubHomePage(),
    );
  }
}

class HabitHubHomePage extends StatefulWidget {
  const HabitHubHomePage({Key? key}) : super(key: key);

  @override
  State<HabitHubHomePage> createState() => _HabitHubHomePageState();
}

class _HabitHubHomePageState extends State<HabitHubHomePage> {
  List<Habit> _habits = [];
  final _habitController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _reminderTimeController = TextEditingController();

  void _addHabit() {
    if (_habitController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _reminderTimeController.text.isNotEmpty) {
      setState(() {
        _habits.add(
          Habit(
            title: _habitController.text,
            description: _descriptionController.text,
            reminderTime: _reminderTimeController.text,
          ),
        );
        _habitController.clear();
        _descriptionController.clear();
        _reminderTimeController.clear();
      });
    }
  }

  void _deleteHabit(Habit habit) {
    setState(() {
      _habits.remove(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitHub'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _habitController,
                    decoration: const InputDecoration(
                      labelText: 'Habit Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Habit Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _reminderTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Reminder Time',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addHabit,
                  child: const Text('Add Habit'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _habits.length,
                itemBuilder: (context, index) {
                  return HabitCard(
                    habit: _habits[index],
                    onDelete: () => _deleteHabit(_habits[index]),
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

class Habit {
  final String title;
  final String description;
  final String reminderTime;

  Habit({
    required this.title,
    required this.description,
    required this.reminderTime,
  });
}

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onDelete;

  const HabitCard({
    Key? key,
    required this.habit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habit.title,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(habit.description),
            const SizedBox(height: 8),
            Text('Reminder Time: ${habit.reminderTime}'),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onDelete,
                child: const Text('Delete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```