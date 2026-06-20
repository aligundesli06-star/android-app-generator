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
  bool _isDark = false;
  String _language = 'English';

  void _toggleDarkMode() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDark
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: MyHomePage(
        currentIndex: _currentIndex,
        isDark: _isDark,
        language: _language,
        onToggleDarkMode: _toggleDarkMode,
        onChangeLanguage: _changeLanguage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final String language;
  final Function onToggleDarkMode;
  final Function onChangeLanguage;

  const MyHomePage({
    Key? key,
    required this.currentIndex,
    required this.isDark,
    required this.language,
    required this.onToggleDarkMode,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<FoodItem> _foodItems = [
    FoodItem('Apple', 'Fruit', 95, 0.3),
    FoodItem('Banana', 'Fruit', 105, 0.3),
    FoodItem('Chicken Breast', 'Protein', 165, 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Diary'),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    switch (widget.currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildProgressScreen();
      case 2:
        return _buildSettingsScreen();
      default:
        return const Center(
          child: Text('Unknown Screen'),
        );
    }
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _foodItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.food_bank,
                    size: 40,
                    color: Colors.indigo,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _foodItems[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _foodItems[index].category,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${_foodItems[index].calories} calories, ${_foodItems[index].weight}g',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Progress',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.bar_chart,
                size: 40,
                color: Colors.indigo,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'You have consumed 2000 calories today',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Carbs',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Protein',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Fat',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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

  Widget _buildSettingsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Switch(
                value: widget.isDark,
                onChanged: (value) {
                  widget.onToggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              DropdownButton(
                value: widget.language,
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  widget.onChangeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              currentIndex: index,
              isDark: widget.isDark,
              language: widget.language,
              onToggleDarkMode: widget.onToggleDarkMode,
              onChangeLanguage: widget.onChangeLanguage,
            ),
          ),
        );
      },
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
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddFoodItemScreen(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class AddFoodItemScreen extends StatefulWidget {
  const AddFoodItemScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the food item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {