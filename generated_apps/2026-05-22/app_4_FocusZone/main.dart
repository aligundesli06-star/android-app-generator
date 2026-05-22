import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme();
  }
}

class DynamicTheme extends StatefulWidget {
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusZone',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: MyHomePage(
        isDarkMode: _isDarkMode,
        selectedLanguage: _selectedLanguage,
        onThemeChange: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
        onLanguageChange: (String value) {
          setState(() {
            _selectedLanguage = value;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Function(bool) onThemeChange;
  final Function(String) onLanguageChange;

  const MyHomePage({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onThemeChange,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<bool> _isCompleted = [false, false, false];
  int _seconds = 1500;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _newItemController = TextEditingController();

  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = 1500;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            isDarkMode: widget.isDarkMode,
            onThemeChange: widget.onThemeChange,
            onLanguageChange: widget.onLanguageChange,
            selectedLanguage: widget.selectedLanguage,
            startTimer: _startTimer,
            stopTimer: _stopTimer,
            resetTimer: _resetTimer,
            seconds: _seconds,
            isCompleted: _isCompleted,
            scrollController: _scrollController,
            newItemController: _newItemController,
          ),
          ProgressScreen(
            isDarkMode: widget.isDarkMode,
            isCompleted: _isCompleted,
          ),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            selectedLanguage: widget.selectedLanguage,
            onThemeChange: widget.onThemeChange,
            onLanguageChange: widget.onLanguageChange,
          ),
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
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentIndex == 0) {
            _showAddNewDialog();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: _newItemController,
            decoration: const InputDecoration(hintText: 'Enter new item'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_newItemController.text.isNotEmpty) {
                  setState(() {
                    _isCompleted.add(false);
                  });
                  _newItemController.clear();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChange;
  final Function(String) onLanguageChange;
  final String selectedLanguage;
  final Function startTimer;
  final Function stopTimer;
  final Function resetTimer;
  final int seconds;
  final List<bool> isCompleted;
  final ScrollController scrollController;
  final TextEditingController newItemController;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChange,
    required this.onLanguageChange,
    required this.selectedLanguage,
    required this.startTimer,
    required this.stopTimer,
    required this.resetTimer,
    required this.seconds,
    required this.isCompleted,
    required this.scrollController,
    required this.newItemController,
  }) : super(key: key);

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
                  const Icon(Icons.timer),
                  const SizedBox(width: 16),
                  Text(
                    '$seconds',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: isCompleted.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isCompleted[index],
                          onChanged: (bool? value) {
                            if (value != null) {
                              isCompleted[index] = value;
                            }
                          },
                        ),
                        const SizedBox(width: 16),
                        Text('Task $index'),
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
  final bool isDarkMode;
  final List<bool> isCompleted;

  const ProgressScreen({
    Key? key,
    required this.isDarkMode,
    required this.isCompleted,
  }) : super(key: key);

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
                  const Icon(Icons.bar_chart),
                  const SizedBox(width: 16),
                  Text(
                    '${isCompleted.where((bool value) => value).length} / ${isCompleted.length}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: isCompleted.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isCompleted[index],
                          onChanged: (bool? value) {},
                        ),
                        const SizedBox(width: 16),
                        Text('Task $index'),
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

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Function(bool) onThemeChange;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onThemeChange,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {