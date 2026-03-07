import 'package:flutter/material.dart';

void main() {
  runApp(const WalkBuddy());
}

class WalkBuddy extends StatelessWidget {
  const WalkBuddy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalkBuddy',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
        ),
      ),
      home: const WalkBuddyHome(),
    );
  }
}

class WalkBuddyHome extends StatefulWidget {
  const WalkBuddyHome({Key? key}) : super(key: key);

  @override
  State<WalkBuddyHome> createState() => _WalkBuddyHomeState();
}

class _WalkBuddyHomeState extends State<WalkBuddyHome> {
  int _steps = 0;
  double _distance = 0;
  int _calories = 0;
  final _formKey = GlobalKey<FormState>();
  final _goalController = TextEditingController();

  void _incrementSteps() {
    setState(() {
      _steps++;
      _distance += 0.0005;
      _calories += 0.05;
    });
  }

  void _resetData() {
    setState(() {
      _steps = 0;
      _distance = 0;
      _calories = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: const Text('WalkBuddy'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.directions_walk,
                              size: 36,
                            ),
                            Text(
                              '$_steps steps',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.map,
                              size: 36,
                            ),
                            Text(
                              '${_distance.toStringAsFixed(2)} km',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.fireplace,
                              size: 36,
                            ),
                            Text(
                              '$_calories calories',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _goalController,
                      decoration: const InputDecoration(
                        labelText: 'Set daily goal',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a goal';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save goal to database or shared preferences
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Goal set to ${_goalController.text} steps',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Set Goal'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _incrementSteps,
              child: const Icon(
                Icons.add,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (_steps == 0)
              const Text(
                'No steps recorded yet. Get moving!',
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementSteps,
        tooltip: 'Increment steps',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}