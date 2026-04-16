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

  final List< Habit > _habits = [
    Habit('Exercise', Icons.directions_run, '30 minutes'),
    Habit('Meditation', Icons.accessibility, '15 minutes'),
    Habit('Reading', Icons.book, '1 hour'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitHero',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [_HomeScreen(), _ProgressScreen(), _SettingsScreen()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
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
              builder: (context) => AddHabitDialog(),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String title;
  final IconData icon;
  final String duration;

  Habit(this.title, this.icon, this.duration);
}

class _HomeScreen extends StatefulWidget {
  @override
  __HomeScreenState createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
  final MyApp _myApp = MyApp();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _myApp._habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    _myApp._habits[index].icon,
                    size: 40,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _myApp._habits[index].title,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        _myApp._habits[index].duration,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Progress',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Habits',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Stats',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsScreen extends StatefulWidget {
  @override
  __SettingsScreenState createState() => __SettingsScreenState();
}

class __SettingsScreenState extends State<_SettingsScreen> {
  final MyApp _myApp = MyApp();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Switch(
                value: _myApp._isDarkMode,
                onChanged: (value) {
                  _myApp.setState(() {
                    _myApp._isDarkMode = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Language',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              DropdownButton(
                value: _myApp._language,
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
                onChanged: (value) {
                  _myApp.setState(() {
                    _myApp._language = value;
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

class AddHabitDialog extends StatefulWidget {
  @override
  _AddHabitDialogState createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _titleController = TextEditingController();
  final _iconController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Habit',
        style: TextStyle(fontSize: 24),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _iconController,
            decoration: InputDecoration(
              labelText: 'Icon',
            ),
          ),
          TextField(
            controller: _durationController,
            decoration: InputDecoration(
              labelText: 'Duration',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            MyApp _myApp = MyApp();
            _myApp._habits.add(
              Habit(
                _titleController.text,
                Icons.directions_run,
                _durationController.text,
              ),
            );
            _myApp.setState(() {});
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}