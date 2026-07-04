import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  String language = 'English';
  int _currentIndex = 0;
  List HabiList = [
    {'name': 'Morning Run', 'icon': Icons.directions_run},
    {'name': 'Reading', 'icon': Icons.book},
    {'name': 'Meditation', 'icon': Icons.self_improvement},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        HabiList: HabiList,
        isDarkMode: isDarkMode,
        language: language,
        onItemTapped: _onItemTapped,
        currentIndex: _currentIndex,
        onModeChange: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
        onLanguageChange: (value) {
          setState(() {
            language = value;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List HabiList;
  final bool isDarkMode;
  final String language;
  final void Function(int) onItemTapped;
  final int currentIndex;
  final void Function(bool) onModeChange;
  final void Function(String) onLanguageChange;

  const HomeScreen({
    super.key,
    required this.HabiList,
    required this.isDarkMode,
    required this.language,
    required this.onItemTapped,
    required this.currentIndex,
    required this.onModeChange,
    required this.onLanguageChange,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.currentIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.HabiList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Icon(widget.HabiList[index]['icon']),
                                const SizedBox(width: 16),
                                Text(widget.HabiList[index]['name']),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : widget.currentIndex == 1
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Icon(Icons.bar_chart),
                                    const Text('Progress'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Icon(Icons.timer),
                                    const Text('Time'),
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
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    const Text('Schedule'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Icon(Icons.notifications),
                                    const Text('Reminders'),
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
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Dark Mode'),
                          const SizedBox(width: 16),
                          Switch(
                            value: widget.isDarkMode,
                            onChanged: (value) {
                              widget.onModeChange(value);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Language'),
                          const SizedBox(width: 16),
                          DropdownButton(
                            value: widget.language,
                            items: [
                              DropdownMenuItem(
                                child: const Text('English'),
                                value: 'English',
                              ),
                              DropdownMenuItem(
                                child: const Text('Turkish'),
                                value: 'Turkish',
                              ),
                              DropdownMenuItem(
                                child: const Text('Spanish'),
                                value: 'Spanish',
                              ),
                            ],
                            onChanged: (value) {
                              widget.onLanguageChange(value.toString());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onItemTapped,
        items: const [
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
                title: const Text('Add New Habit'),
                content: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Habit Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}