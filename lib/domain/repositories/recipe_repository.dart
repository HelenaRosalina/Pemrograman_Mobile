import 'package:taste_guide/data/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> fetchRecipes();
}
