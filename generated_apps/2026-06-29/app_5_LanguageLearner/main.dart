import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
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
  String _selectedLanguage = 'English';
  List _lessons = [
    {'title': 'Lesson 1', 'description': 'Introduction to language learning'},
    {'title': 'Lesson 2', 'description': 'Basic vocabulary and grammar'},
    {'title': 'Lesson 3', 'description': 'Practice and review'},
  ];

  void _addNewLesson() {
    setState(() {
      _lessons.add({'title': 'New Lesson', 'description': 'New lesson description'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LanguageLearner'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      bottomNavigationBar: _isDarkMode
          ? Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey[800],
                brightness: Brightness.dark,
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
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
            )
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
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
      body: _currentIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _lessons.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            size: 36,
                            color: _isDarkMode ? Colors.white : Colors.indigo,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _lessons[index]['title'],
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                _lessons[index]['description'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : _currentIndex == 1
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Lessons Completed',
                                      style: TextStyle(fontSize: 14, color: _isDarkMode ? Colors.white : Colors.indigo),
                                    ),
                                    Text(
                                      '10',
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Total Points',
                                      style: TextStyle(fontSize: 14, color: _isDarkMode ? Colors.white : Colors.indigo),
                                    ),
                                    Text(
                                      '100',
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Badges Earned',
                                      style: TextStyle(fontSize: 14, color: _isDarkMode ? Colors.white : Colors.indigo),
                                    ),
                                    Text(
                                      '5',
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Streak',
                                      style: TextStyle(fontSize: 14, color: _isDarkMode ? Colors.white : Colors.indigo),
                                    ),
                                    Text(
                                      '10 days',
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Row(
                      children: [
                        const Text('Language: '),
                        DropdownButton(
                          value: _selectedLanguage,
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
                            setState(() {
                              _selectedLanguage = value as String;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Dark Mode: '),
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
                  ],
                ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: _addNewLesson,
              tooltip: 'Add New Lesson',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}