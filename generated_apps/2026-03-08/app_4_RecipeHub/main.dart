import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useMaterial3: true,
      title: 'RecipeHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF34A8FF)),
      ),
      home: const RecipeHub(),
    );
  }
}

class RecipeHub extends StatefulWidget {
  const RecipeHub({Key? key}) : super(key: key);

  @override
  State<RecipeHub> createState() => _RecipeHubState();
}

class _RecipeHubState extends State<RecipeHub> {
  List<Recipe> _recipes = [
    Recipe(
      id: 1,
      title: 'Grilled Chicken',
      description: 'Grilled chicken breast with roasted vegetables',
      ingredients: ['Chicken breast', 'Onion', 'Bell pepper', 'Tomato'],
    ),
    Recipe(
      id: 2,
      title: 'Salad Bowl',
      description: 'Mixed greens with cherry tomatoes and balsamic vinaigrette',
      ingredients: ['Mixed greens', 'Cherry tomatoes', 'Cucumber', 'Balsamic vinaigrette'],
    ),
  ];

  void _addRecipe() {
    setState(() {
      _recipes.add(
        Recipe(
          id: _recipes.length + 1,
          title: 'New Recipe',
          description: 'New recipe description',
          ingredients: [],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeHub'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _recipes.isEmpty
          ? Center(
              child: Text(
                'No recipes found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _recipes[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _recipes[index].description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          children: _recipes[index].ingredients
                              .map(
                                (ingredient) => Chip(
                                  label: Text(ingredient),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _addRecipe,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Recipe {
  final int id;
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
  });
}