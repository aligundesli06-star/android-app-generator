import 'package:flutter/material.dart';
import 'dart:async';

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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void _changeThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      locale: _locale,
      home: MyHomePage(
        changeThemeMode: _changeThemeMode,
        changeLocale: _changeLocale,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final void Function(ThemeMode) changeThemeMode;
  final void Function(Locale) changeLocale;

  const MyHomePage({
    Key? key,
    required this.changeThemeMode,
    required this.changeLocale,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _exerciseController = TextEditingController();
  final _calorieController = TextEditingController();
  List<String> _exercises = [];

  void _addExercise() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _exercises.add(_exerciseController.text);
      });
      _exerciseController.clear();
      _calorieController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            addExercise: _addExercise,
            exerciseController: _exerciseController,
            calorieController: _calorieController,
            formKey: _formKey,
            exercises: _exercises,
          ),
          ProgressScreen(),
          SettingsScreen(
            changeThemeMode: widget.changeThemeMode,
            changeLocale: widget.changeLocale,
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
        onPressed: _addExercise,
        tooltip: 'Add exercise',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final void Function() addExercise;
  final TextEditingController exerciseController;
  final TextEditingController calorieController;
  final GlobalKey<FormState> formKey;
  final List<String> exercises;

  const HomeScreen({
    Key? key,
    required this.addExercise,
    required this.exerciseController,
    required this.calorieController,
    required this.formKey,
    required this.exercises,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: exerciseController,
                    decoration: const InputDecoration(
                      labelText: 'Exercise',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an exercise';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: calorieController,
                    decoration: const InputDecoration(
                      labelText: 'Calories',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter calories';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
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
                        const Icon(Icons.directions_run),
                        const SizedBox(width: 16),
                        Text(exercises[index]),
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
                    color: Colors.indigo.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.shade200.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Progress',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.shade200.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Workout',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.shade200.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Progress details',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final void Function(ThemeMode) changeThemeMode;
  final void Function(Locale) changeLocale;

  const SettingsScreen({
    Key? key,
    required this.changeThemeMode,
    required this.changeLocale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode'),
              const SizedBox(width: 16),
              Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  if (value) {
                    changeThemeMode(ThemeMode.dark);
                  } else {
                    changeThemeMode(ThemeMode.light);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: Localizations.localeOf(context).languageCode,
                  items: [
                    DropdownMenuItem(
                      child: const Text('English'),
                      value: 'en',
                    ),
                    DropdownMenuItem(
                      child: const Text('Türkçe'),
                      value: 'tr',
                    ),
                    DropdownMenuItem(
                      child: const Text('Español'),
                      value: 'es',
                    ),
                  ],
                  onChanged: (value) {
                    if (value == 'en') {
                      changeLocale(const Locale('en'));
                    } else if (value == 'tr') {
                      changeLocale(const Locale('tr'));
                    } else if (value == 'es') {
                      changeLocale(const Locale('es'));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}