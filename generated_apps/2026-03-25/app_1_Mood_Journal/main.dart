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
      title: 'Mood Journal',
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

  final List<Mood> _moods = [
    Mood('Happy', 'I had a great day today', Icons.smile, Colors.yellow),
    Mood('Sad', 'I felt sad today', Icons.sentiment_dissatisfied, Colors.blue),
    Mood('Neutral', 'I felt neutral today', Icons.sentiment_neutral, Colors.grey),
  ];

  void _addMood() {
    setState(() {
      _moods.add(Mood('New Mood', 'New mood description', Icons.add, Colors.green));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentIndex == 0
            ? _homeScreen()
            : _currentIndex == 1
                ? _progressScreen()
                : _settingsScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMood,
        tooltip: 'Add Mood',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _homeScreen() {
    return ListView.builder(
      itemCount: _moods.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(_moods[index].icon, color: _moods[index].color),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_moods[index].title, style: Theme.of(context).textTheme.titleLarge),
                      Text(_moods[index].description),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _progressScreen() {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Indicator(color: Colors.yellow, title: 'Happy', value: 30)),
            Expanded(child: Indicator(color: Colors.blue, title: 'Sad', value: 20)),
            Expanded(child: Indicator(color: Colors.grey, title: 'Neutral', value: 50)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(child: Indicator(color: Colors.green, title: 'New Mood', value: 10)),
          ],
        ),
      ],
    );
  }

  Widget _settingsScreen() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: _isDarkMode,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
            });
          },
        ),
        const SizedBox(height: 16),
        DropdownButton(
          value: _language,
          onChanged: (String? value) {
            setState(() {
              _language = value!;
            });
          },
          items: const [
            DropdownMenuItem(child: Text('English'), value: 'English'),
            DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
            DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
          ],
        ),
      ],
    );
  }
}

class Mood {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  Mood(this.title, this.description, this.icon, this.color);
}

class Indicator extends StatelessWidget {
  final Color color;
  final String title;
  final int value;

  const Indicator({Key? key, required this.color, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                width: 100,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              Container(
                width: 100 * (value / 100),
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('$value%'),
        ],
      ),
    );
  }
}