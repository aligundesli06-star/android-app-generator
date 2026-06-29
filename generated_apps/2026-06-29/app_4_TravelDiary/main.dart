import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelDiary',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<TravelItem> _travelItems = [
    TravelItem('Trip to Paris', 'Eiffel Tower', '2022-01-01', '2022-01-10'),
    TravelItem('Trip to Rome', 'Colosseum', '2022-02-01', '2022-02-10'),
    TravelItem('Trip to Barcelona', 'Sagrada Familia', '2022-03-01', '2022-03-10'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? HomeScreen(_travelItems)
          : _currentIndex == 1
              ? ProgressScreen()
              : SettingsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add New Travel Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Trip Name',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Destination',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'End Date',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _travelItems.add(
                          TravelItem(
                            'New Trip',
                            'New Destination',
                            '2022-01-01',
                            '2022-01-10',
                          ),
                        );
                      });
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<TravelItem> _travelItems;

  HomeScreen(this._travelItems);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _travelItems.map((item) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.airplane,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.tripName,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        item.destination,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '${item.startDate} - ${item.endDate}',
                        style: TextStyle(fontSize: 14),
                      ),
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
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                size: 24,
              ),
              SizedBox(width: 16),
              Text(
                'Progress',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            '10 trips completed',
            style: TextStyle(fontSize: 14),
          ),
          Text(
            '20 destinations visited',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                size: 24,
              ),
              SizedBox(width: 16),
              Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 16),
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
          Row(
            children: [
              Text(
                'Language',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 16),
              DropdownButton(
                value: _language,
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                  });
                },
                items: [
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TravelItem {
  String tripName;
  String destination;
  String startDate;
  String endDate;

  TravelItem(
    this.tripName,
    this.destination,
    this.startDate,
    this.endDate,
  );
}