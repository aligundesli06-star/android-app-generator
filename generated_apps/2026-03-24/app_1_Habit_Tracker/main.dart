import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HabitTrackerApp();
  }
}

class HabitTrackerApp extends StatefulWidget {
  const HabitTrackerApp({Key? key}) : super(key: key);

  @override
  State<HabitTrackerApp> createState() => _HabitTrackerAppState();
}

class _HabitTrackerAppState extends State<HabitTrackerApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  Locale? _locale;
  List<Habit> _habits = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _locale = const Locale('en');
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _addHabit(String name) {
    setState(() {
      _habits.add(Habit(name: name, frequency: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final _controller = TextEditingController();
                return AlertDialog(
                  title: Text(_locale.toString() == 'en' ? 'Add Habit' : _locale.toString() == 'tr' ? 'Alışkanlık Ekle' : 'Agregar Hábito'),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return _locale.toString() == 'en' ? 'Habit name is required' : _locale.toString() == 'tr' ? 'Alışkanlık adı gerekli' : 'Nombre del hábito es requerido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Habit Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(_locale.toString() == 'en' ? 'Cancel' : _locale.toString() == 'tr' ? 'İptal' : 'Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _addHabit(_controller.text);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(_locale.toString() == 'en' ? 'Add' : _locale.toString() == 'tr' ? 'Ekle' : 'Agregar'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: PageView(
          children: [
            HomeScreen(habits: _habits),
            ProgressScreen(habits: _habits),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              toggleDarkMode: _toggleDarkMode,
              locale: _locale,
              changeLanguage: _changeLanguage,
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
              label: _locale.toString() == 'en' ? 'Home' : _locale.toString() == 'tr' ? 'Anasayfa' : 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: _locale.toString() == 'en' ? 'Progress' : _locale.toString() == 'tr' ? 'İlerleme' : 'Progreso',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: _locale.toString() == 'en' ? 'Settings' : _locale.toString() == 'tr' ? 'Ayarlar' : 'Configuración',
            ),
          ],
        ),
      ),
    );
  }
}

class Habit {
  final String name;
  final int frequency;

  Habit({required this.name, required this.frequency});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;

  const HomeScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.check_box),
                  const SizedBox(width: 16),
                  Text(
                    habits[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
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
  final List<Habit> habits;

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(
                    habits[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${habits[index].frequency} times',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function toggleDarkMode;
  final Locale? locale;
  final Function changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.locale,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: widget.locale,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: Text('Español'),
                    value: Locale('es'),
                  ),
                ],
                onChanged: (Locale? value) {
                  widget.changeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}