import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatefulWidget {
  const RecipeBookApp({Key? key}) : super(key: key);

  @override
  State<RecipeBookApp> createState() => _RecipeBookAppState();
}

class _RecipeBookAppState extends State<RecipeBookApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const ProgressScreen(),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onDarkModeToggle: (value) => setState(() => _isDarkMode = value),
              onLanguageChange: (value) => setState(() => _language = value),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Icon(Icons.restaurant, size: 48),
                const Text('Recipe 1', style: TextStyle(fontSize: 24)),
                const Text('Description for recipe 1'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Icon(Icons.restaurant, size: 48),
                const Text('Recipe 2', style: TextStyle(fontSize: 24)),
                const Text('Description for recipe 2'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Progress: '),
              LinearProgressIndicator(
                value: 0.5,
                minHeight: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Progress: '),
              LinearProgressIndicator(
                value: 0.8,
                minHeight: 20,
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
  final Function(bool) onDarkModeToggle;
  final Function(String) onLanguageChange;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeToggle,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode: '),
              Switch(
                value: isDarkMode,
                onChanged: (value) => onDarkModeToggle(value),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language: '),
              DropdownButton(
                value: language,
                items: [
                  const DropdownMenuItem(child: Text('English'), value: 'English'),
                  const DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  const DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
                onChanged: (value) => onLanguageChange(value as String),
              ),
            ],
          ),
        ],
      ),
    );
  }
}