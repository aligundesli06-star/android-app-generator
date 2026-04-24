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
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
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
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AddBookDialog();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.book,
                  size: 48,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Book Title',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Book Author',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.book,
                  size: 48,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Book Title',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Book Author',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.bar_chart,
              size: 48,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Reading Progress',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              'Books Read: 10',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Pages Read: 500',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.settings,
              size: 48,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              'Theme:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              width: 16,
            ),
            Switch(
              value: (_MyAppState())!.isDarkMode,
              onChanged: (value) {
                (_MyAppState())!.setState(() {
                  (_MyAppState())!._isDarkMode = value;
                });
              },
            ),
            const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              'Language:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              width: 16,
            ),
            DropdownButton(
              value: (_MyAppState())!._language,
              items: const [
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
                (_MyAppState())!.setState(() {
                  (_MyAppState())!._language = value as String;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({super.key});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Book Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter book title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Book Author',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter book author';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Book added'),
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}