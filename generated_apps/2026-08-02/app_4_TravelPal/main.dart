import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelPal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
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
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final _tripCards = [
    {
      'title': 'Trip to Paris',
      'destination': 'Paris, France',
      'startDate': '2024-03-01',
      'endDate': '2024-03-10',
    },
    {
      'title': 'Trip to Tokyo',
      'destination': 'Tokyo, Japan',
      'startDate': '2024-06-01',
      'endDate': '2024-06-15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelPal'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _homeScreen(),
          _progressScreen(),
          _settingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
          setState(() {
            _tripCards.add({
              'title': 'New Trip',
              'destination': 'New Destination',
              'startDate': '2024-01-01',
              'endDate': '2024-01-31',
            });
          });
        },
        tooltip: 'Add New Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _homeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: _tripCards.map((trip) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['title']!,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.place),
                      const SizedBox(width: 8.0),
                      Text(trip['destination']!),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 8.0),
                      Text('${trip['startDate']} - ${trip['endDate']}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _progressScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 8.0),
              Text(
                'Progress',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            color: Colors.indigo,
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Text('Completed'),
                    Text('50%'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Text('Remaining'),
                    Text('50%'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _settingsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 8.0),
              Text(
                'Settings',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 8.0),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 8.0),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}