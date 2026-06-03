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
  int _workTime = 25;
  int _breakTime = 5;
  List<WorkSession> _workSessions = [];
  Timer? _timer;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: _workTime), (timer) {
      if (_workSessions.isEmpty) {
        _workSessions.add(WorkSession(Duration(minutes: _workTime), 'Work Session'));
      } else {
        _workSessions.add(WorkSession(Duration(minutes: _breakTime), 'Break Session'));
      }
      setState(() {});
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusTimer',
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
          children: [
            HomeScreen(
              workTime: _workTime,
              breakTime: _breakTime,
              startTimer: _startTimer,
              stopTimer: _stopTimer,
              workSessions: _workSessions,
            ),
            ProgressScreen(workSessions: _workSessions),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              toggleDarkMode: _toggleDarkMode,
              language: _language,
              selectLanguage: _selectLanguage,
            ),
          ],
        ),
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
              label: _language == 'English' ? 'Home' : _language == 'Turkish' ? 'Ana Sayfa' : 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: _language == 'English' ? 'Progress' : _language == 'Turkish' ? 'İlerleme' : 'Progreso',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: _language == 'English' ? 'Settings' : _language == 'Turkish' ? 'Ayarlar' : 'Ajustes',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _workSessions.add(WorkSession(Duration(minutes: _workTime), 'New Session'));
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int workTime;
  final int breakTime;
  final Function startTimer;
  final Function stopTimer;
  final List<WorkSession> workSessions;

  HomeScreen({
    required this.workTime,
    required this.breakTime,
    required this.startTimer,
    required this.stopTimer,
    required this.workSessions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.timer),
                  SizedBox(width: 16),
                  Text(
                    'Work Time: $workTime minutes',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.timer_off),
                  SizedBox(width: 16),
                  Text(
                    'Break Time: $breakTime minutes',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              startTimer();
            },
            child: Text('Start Timer'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              stopTimer();
            },
            child: Text('Stop Timer'),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: workSessions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(width: 16),
                        Text(
                          '${workSessions[index].duration.inMinutes} minutes - ${workSessions[index].type}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<WorkSession> workSessions;

  ProgressScreen({required this.workSessions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text(
                'Total Work Time: ${workSessions.fold(0, (total, session) => total + session.duration.inMinutes)} minutes',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.timer),
              SizedBox(width: 16),
              Text(
                'Total Break Time: ${workSessions.fold(0, (total, session) => session.type == 'Break Session' ? total + session.duration.inMinutes : total)} minutes',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: workSessions.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Icon(Icons.timer),
                    SizedBox(width: 16),
                    Text(
                      '${workSessions[index].duration.inMinutes} minutes - ${workSessions[index].type}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function toggleDarkMode;
  final String language;
  final Function selectLanguage;

  SettingsScreen({
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.language,
    required this.selectLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.dark_mode),
              SizedBox(width: 16),
              Text(
                'Dark Mode',
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.language),
              SizedBox(width: 16),
              Text(
                'Language',
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              DropdownButton(
                value: language,
                items: [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Español'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  selectLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkSession {
  final Duration duration;
  final String type;

  WorkSession(this.duration, this.type);
}