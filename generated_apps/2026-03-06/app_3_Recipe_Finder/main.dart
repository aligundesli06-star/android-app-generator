```dart
import 'package:flutter/material.dart';
import 'package:recipe_finder/models/recipe.dart';
import 'package:recipe_finder/services/recipe_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final _recipeService = RecipeService();
  final _formKey = GlobalKey<FormState>();
  final _dietaryPreferences = ['Vegetarian', 'Vegan', 'Gluten-free'];
  final _selectedDietaryPreferences = <String>[];
  final _ingredientsController = TextEditingController();
  List<Recipe> _recipes = [];

  Future<void> _getRecipes() async {
    final recipes = await _recipeService.getRecipes(
      dietaryPreferences: _selectedDietaryPreferences,
      ingredients: _ingredientsController.text,
    );
    setState(() {
      _recipes = recipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Dietary Preferences:'),
                  Wrap(
                    spacing: 10,
                    children: _dietaryPreferences.map((preference) {
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_selectedDietaryPreferences.contains(preference)) {
                              _selectedDietaryPreferences.remove(preference);
                            } else {
                              _selectedDietaryPreferences.add(preference);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedDietaryPreferences.contains(preference)
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: Text(preference),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _ingredientsController,
                    decoration: const InputDecoration(
                      labelText: 'Ingredients (comma-separated)',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _getRecipes();
                    },
                    child: const Text('Get Recipes'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_recipes[index].name, style: const TextStyle(fontSize: 18)),
                          Text(_recipes[index].description),
                          Text('Ingredients: ${_recipes[index].ingredients.join(', ')}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Recipe {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
  });
}

class RecipeService {
  Future<List<Recipe>> getRecipes({
    List<String>? dietaryPreferences,
    String? ingredients,
  }) async {
    // Simulate a delay for API call
    await Future.delayed(const Duration(milliseconds: 500));
    // Return sample recipes
    return [
      Recipe(
        id: '1',
        name: 'Vegetable Soup',
        description: 'A delicious vegetable soup',
        ingredients: ['carrots', 'celery', 'potatoes'],
      ),
      Recipe(
        id: '2',
        name: 'Grilled Cheese Sandwich',
        description: 'A tasty grilled cheese sandwich',
        ingredients: ['bread', 'cheese'],
      ),
    ];
  }
}
```