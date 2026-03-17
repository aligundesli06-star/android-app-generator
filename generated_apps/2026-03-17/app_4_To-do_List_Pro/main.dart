import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.indigo,
  );
  bool _isDark = false;
  Locale _locale = const Locale('en');

  void _changeTheme() {
    setState(() {
      _isDark = !_isDark;
      _themeData = _isDark
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData(
              primarySwatch: Colors.indigo,
            );
    });
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  final List<_Task> _tasks = [
    _Task('Task 1', 'Description 1'),
    _Task('Task 2', 'Description 2'),
    _Task('Task 3', 'Description 3'),
  ];

  void _addTask() {
    final _newTask = _Task('New Task', 'New Description');
    setState(() {
      _tasks.add(_newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      theme: _themeData,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              tasks: _tasks,
              addTask: _addTask,
            ),
            ProgressScreen(),
            SettingsScreen(
              changeTheme: _changeTheme,
              changeLanguage: _changeLanguage,
              isDark: _isDark,
              locale: _locale.languageCode,
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
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _Task {
  final String title;
  final String description;

  _Task(this.title, this.description);
}

class HomeScreen extends StatelessWidget {
  final List<_Task> tasks;
  final VoidCallback addTask;

  const HomeScreen({
    Key? key,
    required this.tasks,
    required this.addTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.check_box),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tasks[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(tasks[index].description),
                      ],
                    ),
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

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const ProgressIndicator(),
        ],
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text('50%'),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback changeTheme;
  final Function(String) changeLanguage;
  final bool isDark;
  final String locale;

  const SettingsScreen({
    Key? key,
    required this.changeTheme,
    required this.changeLanguage,
    required this.isDark,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 16),
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: isDark,
            onChanged: (value) {
              changeTheme();
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton(
              value: locale,
              onChanged: (String? value) {
                changeLanguage(value!);
              },
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'tr',
                  child: Text('Turkish'),
                ),
                DropdownMenuItem(
                  value: 'es',
                  child: Text('Spanish'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}