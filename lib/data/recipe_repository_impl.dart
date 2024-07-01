import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recipe.dart';
import 'package:taste_guide/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/random?number=20&apiKey=198fa8b75e4240928e18ad7d0a44533c'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return (data['recipes'] as List<dynamic>)
          .map((json) => Recipe.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }
}
