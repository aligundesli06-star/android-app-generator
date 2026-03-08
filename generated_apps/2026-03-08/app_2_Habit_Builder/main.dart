import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Habit Builder',
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
  List<Habit> _habits = [];
  Locale _locale = const Locale('en');
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _habits.add(Habit('Exercise', 'Run for 30 minutes', DateTime.now()));
    _habits.add(Habit('Meditation', 'Meditate for 10 minutes', DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Builder'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(_habits, _onAddHabit),
          StatsScreen(_habits),
          SettingsScreen(
            _onToggleDarkMode,
            _onLocaleChanged,
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
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddHabit,
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddHabit() {
    showDialog(
      context: context,
      builder: (context) {
        final _nameController = TextEditingController();
        final _descriptionController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
            ],
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
                setState(() {
                  _habits.add(Habit(
                    _nameController.text,
                    _descriptionController.text,
                    DateTime.now(),
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onToggleDarkMode(bool value) {
    setState(() {
      _darkMode = value;
      if (_darkMode) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ));
      } else {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ));
      }
    });
  }

  void _onLocaleChanged(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final VoidCallback onAddHabit;

  const HomeScreen(this.habits, this.onAddHabit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return habits.isEmpty
        ? EmptyState(
            icon: Icons.add_task,
            message: 'No habits added yet',
          )
        : ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
              return HabitsCard(habits[index]);
            },
          );
  }
}

class HabitsCard extends StatelessWidget {
  final Habit habit;

  const HabitsCard(this.habit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.task,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Text(
                  habit.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Text(habit.description),
            Text(DateFormat('yyyy-MM-dd').format(habit.date)),
          ],
        ),
      ),
    );
  }
}

class StatsScreen extends StatelessWidget {
  final List<Habit> habits;

  const StatsScreen(this.habits, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return habits.isEmpty
        ? EmptyState(
            icon: Icons.bar_chart,
            message: 'No habits added yet',
          )
        : ListView(
            children: habits.map((habit) {
              return ListTile(
                title: Text(habit.name),
                subtitle: Text(DateFormat('yyyy-MM-dd').format(habit.date)),
              );
            }).toList(),
          );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) onToggleDarkMode;
  final Function(Locale) onLocaleChanged;

  const SettingsScreen(this.onToggleDarkMode, this.onLocaleChanged, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Dark Mode'),
          trailing: Switch(
            value: false,
            onChanged: onToggleDarkMode as void Function(bool)?,
          ),
        ),
        ListTile(
          title: const Text('Language'),
          trailing: DropdownButton(
            value: Locale('en'),
            items: [
              DropdownMenuItem(
                child: const Text('English'),
                value: Locale('en'),
              ),
              DropdownMenuItem(
                child: const Text('Turkish'),
                value: Locale('tr'),
              ),
              DropdownMenuItem(
                child: const Text('Spanish'),
                value: Locale('es'),
              ),
            ],
            onChanged: (locale) {
              onLocaleChanged(locale as Locale);
            },
          ),
        ),
      ],
    );
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyState({Key? key, required this.icon, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

class Habit {
  final String name;
  final String description;
  final DateTime date;

  Habit(this.name, this.description, this.date);
}