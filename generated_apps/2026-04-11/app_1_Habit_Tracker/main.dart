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
  bool _isDarkMode = false;
  String _language = 'English';

  final List<Habit> _habits = [
    Habit(title: 'Wake up at 7:00', icon: Icons.wb_sunny, isCompleted: false),
    Habit(title: 'Exercise for 30 minutes', icon: Icons.directions_run, isCompleted: false),
    Habit(title: 'Meditate for 15 minutes', icon: Icons.self_improvement, isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData.light().copyWith(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: _currentIndex == 0
            ? HomeScreen(
                habits: _habits,
                addHabit: (habit) {
                  setState(() {
                    _habits.add(habit);
                  });
                },
              )
            : _currentIndex == 1
                ? ProgressScreen(habits: _habits)
                : SettingsScreen(
                    isDarkMode: _isDarkMode,
                    language: _language,
                    toggleDarkMode: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                    changeLanguage: (language) {
                      setState(() {
                        _language = language;
                      });
                    },
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final _titleController = TextEditingController();
                final _icon = ValueNotifier<IconData>(Icons.wb_sunny);

                return AlertDialog(
                  title: Text(_language == 'English' ? 'Add Habit' : _language == 'Turkish' ? 'Alışkanlık Ekle' : 'Agregar Hábito'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: _language == 'English' ? 'Habit Title' : _language == 'Turkish' ? 'Alışkanlık Başlığı' : 'Título del Hábito',
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.wb_sunny),
                            onPressed: () {
                              _icon.value = Icons.wb_sunny;
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.directions_run),
                            onPressed: () {
                              _icon.value = Icons.directions_run;
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.self_improvement),
                            onPressed: () {
                              _icon.value = Icons.self_improvement;
                            },
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                        valueListenable: _icon,
                        builder: (context, iconData, child) {
                          return Icon(_icon.value);
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(_language == 'English' ? 'Cancel' : _language == 'Turkish' ? 'İptal' : 'Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _habits.add(Habit(
                            title: _titleController.text,
                            icon: _icon.value,
                            isCompleted: false,
                          ));
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(_language == 'English' ? 'Add' : _language == 'Turkish' ? 'Ekle' : 'Agregar'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final Function addHabit;

  const HomeScreen({Key? key, required this.habits, required this.addHabit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
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
                  Icon(
                    habits[index].icon,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    habits[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Checkbox(
                    value: habits[index].isCompleted,
                    onChanged: (value) {
                      setState(() {
                        habits[index].isCompleted = value ?? false;
                      });
                    },
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Habits: ${habits.length}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Text(
                'Completed: ${habits.where((habit) => habit.isCompleted).length}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) toggleDarkMode;
  final Function(String) changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                language == 'English' ? 'Dark Mode' : language == 'Turkish' ? 'Koyu Mod' : 'Modo Oscuro',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                language == 'English' ? 'Language' : language == 'Turkish' ? 'Dil' : 'Idioma',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButton(
                value: language,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      language == 'English' ? 'English' : language == 'Turkish' ? 'Türkçe' : 'Español',
                    ),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      language == 'English' ? 'Türkçe' : language == 'Turkish' ? 'English' : 'Turco',
                    ),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      language == 'English' ? 'Español' : language == 'Turkish' ? 'İspanyolca' : 'English',
                    ),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  changeLanguage(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Habit {
  final String title;
  final IconData icon;
  bool isCompleted;

  Habit({required this.title, required this.icon, required this.isCompleted});
}