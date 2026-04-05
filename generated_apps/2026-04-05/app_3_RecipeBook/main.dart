import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBook',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
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
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeBook'),
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.indigo,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          homeScreen(),
          progressScreen(),
          settingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          const BottomNavigationBarItem(
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
          // Add new item
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text('Add New Item'),
                content: Text('RecipeBook'),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget homeScreen() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          child: ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Recipe 1'),
            subtitle: Text('Description 1'),
          ),
        ),
        const Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          child: ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Recipe 2'),
            subtitle: Text('Description 2'),
          ),
        ),
        const Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          child: ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Recipe 3'),
            subtitle: Text('Description 3'),
          ),
        ),
      ],
    );
  }

  Widget progressScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Calories: 1000'),
            const Text('Protein: 50g'),
            const Text('Carbs: 200g'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Fat: 20g'),
            const Text('Sugar: 30g'),
            const Text(' Sodium: 1000mg'),
          ],
        ),
      ],
    );
  }

  Widget settingsScreen() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Dark Mode'),
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Language'),
            DropdownButton(
              value: _selectedLanguage,
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
                setState(() {
                  _selectedLanguage = value as String;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}