import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusFlow',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2196F3)),
      ),
      home: const FocusFlow(),
    );
  }
}

class FocusFlow extends StatefulWidget {
  const FocusFlow({super.key});

  @override
  State<FocusFlow> createState() => _FocusFlowState();
}

class _FocusFlowState extends State<FocusFlow> {
  List<Task> _tasks = [];
  int _currentIndex = 0;
  bool _isRunning = false;
  int _seconds = 25 * 60;
  String _displayText = 'Work Session';

  void _startPomodoro() {
    setState(() {
      _isRunning = true;
    });
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
  }

  void _addTask() {
    setState(() {
      _tasks.add(Task(title: 'New Task ${_tasks.length}', completed: false));
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].completed = !_tasks[index].completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FocusFlow'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text('No tasks yet. Add one below!'),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              _tasks[index].title,
                              style: TextStyle(
                                decoration: _tasks[index].completed
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: Checkbox(
                              value: _tasks[index].completed,
                              onChanged: (value) =>
                                  _toggleTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isRunning
                    ? Text(
                        _displayText +
                            ' (${_formatSeconds(_seconds)})',
                        style: const TextStyle(fontSize: 20),
                      )
                    : ElevatedButton(
                        onPressed: _startPomodoro,
                        child: const Text('Start Pomodoro'),
                      ),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatSeconds(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

class Task {
  final String title;
  bool completed;

  Task({required this.title, this.completed = false});
}