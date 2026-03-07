```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const TravelDiaryApp());
}

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const TravelDiaryHomePage(),
    );
  }
}

class TravelDiaryHomePage extends StatefulWidget {
  const TravelDiaryHomePage({super.key});

  @override
  State<TravelDiaryHomePage> createState() => _TravelDiaryHomePageState();
}

class _TravelDiaryHomePageState extends State<TravelDiaryHomePage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<TravelEntry> _travelEntries = [];

  void _addTravelEntry() {
    if (_locationController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      setState(() {
        _travelEntries.add(
          TravelEntry(
            location: _locationController.text,
            description: _descriptionController.text,
          ),
        );
        _locationController.clear();
        _descriptionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Diary'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addTravelEntry,
                  child: const Text('Add Entry'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _travelEntries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_travelEntries[index].location),
                  subtitle: Text(_travelEntries[index].description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TravelEntry {
  final String location;
  final String description;

  TravelEntry({required this.location, required this.description});
}
```