import 'package:flutter/material.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HabitTracker(),
    );
  }
}

class HabitTracker extends StatefulWidget {
  const HabitTracker({Key? key}) : super(key: key);

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  final List<Habit> _habits = [];
  final _controller = TextEditingController();

  void _addHabit() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _habits.add(Habit(title: _controller.text, completed: false));
        _controller.clear();
      });
    }
  }

  void _toggleHabit(Habit habit) {
    setState(() {
      habit.completed = !habit.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _habits.isEmpty
            ? Center(
                child: Text(
                  'No habits added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : ListView.builder(
                itemCount: _habits.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _habits[index].completed,
                            onChanged: (value) => _toggleHabit(_habits[index]),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _habits[index].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Add new habit',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _addHabit,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Habit {
  final String title;
  bool completed;

  Habit({required this.title, this.completed = false});
}