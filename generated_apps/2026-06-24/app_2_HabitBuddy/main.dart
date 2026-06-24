import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: const App(),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'en';

  bool get isDarkMode => _isDarkMode;
  String get language => _language;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeLanguage(String language) {
    _language = language;
    notifyListeners();
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'HabitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
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
  final _habits = [
    {'name': 'Exercise', 'icon': Icons.directions_run},
    {'name': 'Meditation', 'icon': Icons.meditation},
    {'name': 'Reading', 'icon': Icons.book},
  ];

  void _addNewHabit() {
    setState(() {
      _habits.add({'name': 'New Habit', 'icon': Icons.add});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _habits.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(_habits[index]['icon']),
                        const SizedBox(width: 16),
                        Text(
                          _habits[index]['name'],
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(Icons.bar_chart),
                            const SizedBox(height: 8),
                            Text(
                              'Progress',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(Icons.arrow_upward),
                            const SizedBox(height: 8),
                            Text(
                              'Goal',
                              style: Theme.of(context).textTheme.titleLarge,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(Icons.calendar_today),
                            const SizedBox(height: 8),
                            Text(
                              'Schedule',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(Icons.settings),
                            const SizedBox(height: 8),
                            Text(
                              'Settings',
                              style: Theme.of(context).textTheme.titleLarge,
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Dark Mode'),
                    const SizedBox(width: 16),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Language'),
                    const SizedBox(width: 16),
                    DropdownButton(
                      value: themeProvider.language,
                      items: [
                        DropdownMenuItem(
                          child: const Text('English'),
                          value: 'en',
                        ),
                        DropdownMenuItem(
                          child: const Text('Turkish'),
                          value: 'tr',
                        ),
                        DropdownMenuItem(
                          child: const Text('Spanish'),
                          value: 'es',
                        ),
                      ],
                      onChanged: (value) {
                        themeProvider.changeLanguage(value as String);
                      },
                    ),
                  ],
                ),
              ],
            ),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewHabit,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ChangeNotifierProvider<T> extends StatefulWidget {
  final Create<T> create;
  final Widget child;

  ChangeNotifierProvider({
    required this.create,
    required this.child,
  });

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T> extends State<ChangeNotifierProvider<T>> {
  late T _notifier;

  @override
  void initState() {
    _notifier = widget.create(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedNotifier<T>(
      notifier: _notifier,
      child: widget.child,
    );
  }
}

typedef Create<T> = T Function(BuildContext context);

class InheritedNotifier<T> extends InheritedWidget {
  final T notifier;

  InheritedNotifier({
    required this.notifier,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedNotifier<T> oldWidget) {
    return oldWidget.notifier != notifier;
  }

  static T of<T>(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedNotifier<T>>() as InheritedNotifier<T>).notifier;
  }
}