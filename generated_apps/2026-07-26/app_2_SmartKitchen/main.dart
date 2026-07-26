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
  bool _isDarkMode = false;
  String _lang = 'English';

  void _toggleMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLang(String lang) {
    setState(() {
      _lang = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartKitchen',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SmartKitchen'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(_toggleMode, _changeLang),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
            // Navigate to new item page
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(
                    Icons.restaurant,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Recipe 1',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text('Description'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(
                    Icons.local_grocery_store,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grocery List',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text('Items'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(
                    Icons.timer,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Meal Plan',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text('Schedule'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(
                    Icons.notifications,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Notifications',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text('Alerts'),
                ],
              ),
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
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Text(
                          'Calories',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text('1000'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Text(
                          'Protein',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text('50g'),
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
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Text(
                          'Carbs',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text('200g'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Text(
                          'Fat',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text('20g'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function toggleMode;
  final Function changeLang;

  const SettingsScreen(this.toggleMode, this.changeLang, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 8),
              Switch(
                value: _MyAppState()._isDarkMode,
                onChanged: (value) {
                  toggleMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 8),
              DropdownButton(
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
                  changeLang(value);
                },
                value: _MyAppState()._lang,
              ),
            ],
          ),
        ],
      ),
    );
  }
}