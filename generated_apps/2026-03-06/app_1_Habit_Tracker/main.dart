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
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HabitsPage(),
    );
  }
}

class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  final _habits = [
    {'name': 'Exercise', 'completed': false},
    {'name': 'Meditate', 'completed': false},
    {'name': 'Read', 'completed': false},
  ];

  void _toggleHabit(int index) {
    setState(() {
      _habits[index]['completed'] = !(_habits[index]['completed'] as bool);
    });
  }

  void _addHabit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _controller = TextEditingController();
        return AlertDialog(
          title: const Text('Add Habit'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter habit name'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  _habits.add({'name': _controller.text, 'completed': false});
                });
                Navigator.of(context).pop();
              },
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
        title: const Text('Habit Tracker'),
      ),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_habits[index]['name'] as String),
            trailing: Checkbox(
              value: _habits[index]['completed'] as bool,
              onChanged: (value) {
                _toggleHabit(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```