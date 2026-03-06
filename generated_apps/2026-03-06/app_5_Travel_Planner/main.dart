```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TravelPlanner(),
    );
  }
}

class TravelPlanner extends StatefulWidget {
  const TravelPlanner({Key? key}) : super(key: key);

  @override
  State<TravelPlanner> createState() => _TravelPlannerState();
}

class _TravelPlannerState extends State<TravelPlanner> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _datesController = TextEditingController();
  final _activitiesController = TextEditingController();

  @override
  void dispose() {
    _destinationController.dispose();
    _datesController.dispose();
    _activitiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Planner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _datesController,
                decoration: const InputDecoration(
                  labelText: 'Dates',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dates';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _activitiesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Activities',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter activities';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItineraryScreen(
                          destination: _destinationController.text,
                          dates: _datesController.text,
                          activities: _activitiesController.text,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Create Itinerary'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItineraryScreen extends StatelessWidget {
  final String destination;
  final String dates;
  final String activities;

  const ItineraryScreen({
    Key? key,
    required this.destination,
    required this.dates,
    required this.activities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Your Itinerary:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Destination: $destination',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Dates: $dates',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Activities: $activities',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Planner'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Share itinerary logic
              },
              child: const Text('Share Itinerary'),
            ),
          ],
        ),
      ),
    );
  }
}
```