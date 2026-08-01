import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipePal();
  }
}

class RecipePal extends StatefulWidget {
  @override
  _RecipePalState createState() => _RecipePalState();
}

class _RecipePalState extends State<RecipePal> {
  int _currentIndex = 0;
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipePal',
      theme: _darkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(
              darkModeCallback: (darkMode) {
                setState(() {
                  _darkMode = darkMode;
                });
              },
              languageCallback: (language) {
                setState(() {
                  _language = language;
                });
              },
              darkMode: _darkMode,
              language: _language,
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Add',
          child: Icon(Icons.add),
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
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
        children: [
          HomeCard(
            icon: Icons.pizza,
            title: 'Italian Recipes',
            subtitle: '30+ delicious recipes',
          ),
          HomeCard(
            icon: Icons.ramen,
            title: 'Asian Recipes',
            subtitle: '20+ tasty recipes',
          ),
          HomeCard(
            icon: Icons.taco,
            title: 'Mexican Recipes',
            subtitle: '15+ spicy recipes',
          ),
          HomeCard(
            icon: Icons.sushi,
            title: 'Japanese Recipes',
            subtitle: '10+ unique recipes',
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const HomeCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(subtitle),
          ],
        ),
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
                child: ProgressIndicator(
                  label: 'Progress',
                  value: 0.5,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ProgressIndicator(
                  label: 'Goals',
                  value: 0.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ProgressIndicator(
            label: 'Today',
            value: 0.8,
          ),
        ],
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final String label;
  final double value;

  const ProgressIndicator({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(bool) darkModeCallback;
  final Function(String) languageCallback;
  final bool darkMode;
  final String language;

  const SettingsScreen({
    Key? key,
    required this.darkModeCallback,
    required this.languageCallback,
    required this.darkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Mode'),
              SizedBox(width: 16),
              Switch(
                value: darkMode,
                onChanged: (value) {
                  darkModeCallback(value);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Language'),
              SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: [
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
                  languageCallback(value.toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}