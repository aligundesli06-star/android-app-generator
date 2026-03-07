```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodPal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FoodPalHomePage(),
    );
  }
}

class FoodPalHomePage extends StatefulWidget {
  const FoodPalHomePage({super.key});

  @override
  State<FoodPalHomePage> createState() => _FoodPalHomePageState();
}

class _FoodPalHomePageState extends State<FoodPalHomePage> {
  final _textController = TextEditingController();

  int _currentPage = 0;

  List<Widget> _pages = [
    const NearbyRestaurantsPage(),
    const SharedRecipesPage(),
    const UserProfilesPage(),
  ];

  void _onPageChanged(int newIndex) {
    setState(() {
      _currentPage = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FoodPal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context, _textController);
            },
          ),
        ],
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: _onPageChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profiles',
          ),
        ],
      ),
    );
  }
}

void showSearchDialog(BuildContext context, TextEditingController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Search'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter food name'),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Search'),
            onPressed: () {
              Navigator.of(context).pop();
              // Add search functionality here
            },
          ),
        ],
      );
    },
  );
}

class NearbyRestaurantsPage extends StatelessWidget {
  const NearbyRestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('Restaurant 1'),
          subtitle: Text('5 stars'),
        ),
        ListTile(
          title: Text('Restaurant 2'),
          subtitle: Text('4 stars'),
        ),
        ListTile(
          title: Text('Restaurant 3'),
          subtitle: Text('3 stars'),
        ),
      ],
    );
  }
}

class SharedRecipesPage extends StatelessWidget {
  const SharedRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('Recipe 1'),
          subtitle: Text('Description'),
        ),
        ListTile(
          title: Text('Recipe 2'),
          subtitle: Text('Description'),
        ),
        ListTile(
          title: Text('Recipe 3'),
          subtitle: Text('Description'),
        ),
      ],
    );
  }
}

class UserProfilesPage extends StatelessWidget {
  const UserProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('User 1'),
          subtitle: Text('Dining Experience'),
        ),
        ListTile(
          title: Text('User 2'),
          subtitle: Text('Dining Experience'),
        ),
        ListTile(
          title: Text('User 3'),
          subtitle: Text('Dining Experience'),
        ),
      ],
    );
  }
}
```