import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeFinder',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF66CCCC),
          brightness: Brightness.light,
        ),
      ),
      home: const RecipeFinder(),
    );
  }
}

class RecipeFinder extends StatefulWidget {
  const RecipeFinder({Key? key}) : super(key: key);

  @override
  State<RecipeFinder> createState() => _RecipeFinderState();
}

class _RecipeFinderState extends State<RecipeFinder> {
  final List<Recipe> _recipes = [
    Recipe(
      'Grilled Chicken',
      'https://via.placeholder.com/400x200',
      'Grilled chicken breast with roasted vegetables',
    ),
    Recipe(
      'Baked Salmon',
      'https://via.placeholder.com/400x200',
      'Baked salmon with quinoa and mixed vegetables',
    ),
    Recipe(
      'Vegetable Soup',
      'https://via.placeholder.com/400x200',
      'Creamy vegetable soup with crusty bread',
    ),
  ];

  final List<Recipe> _favorites = [];

  void _addToFavorites(Recipe recipe) {
    setState(() {
      if (!_favorites.contains(recipe)) {
        _favorites.add(recipe);
      }
    });
  }

  void _removeFromFavorites(Recipe recipe) {
    setState(() {
      if (_favorites.contains(recipe)) {
        _favorites.remove(recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeFinder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      body: _recipes.isEmpty
          ? const Center(
              child: Text('No recipes available'),
            )
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image.network(
                          _recipes[index].image,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _recipes[index].title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                _recipes[index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: _favorites.contains(_recipes[index])
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                          onPressed: () {
                            if (_favorites.contains(_recipes[index])) {
                              _removeFromFavorites(_recipes[index]);
                            } else {
                              _addToFavorites(_recipes[index]);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGroceryListDialog(context, _favorites);
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Recipes'),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
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
              },
            ),
          ],
        );
      },
    );
  }

  void showGroceryListDialog(BuildContext context, List<Recipe> recipes) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Grocery List'),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(recipes[index].title),
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Recipe {
  final String title;
  final String image;
  final String description;

  Recipe(this.title, this.image, this.description);
}