import 'package:flutter/material.dart';
import 'package:taste_guide/data/recipe.dart';
import 'package:taste_guide/domain/repositories/recipe_repository.dart'; // Tambahkan ini
import 'package:taste_guide/data/recipe_repository_impl.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeRepository _recipeRepository = RecipeRepositoryImpl();
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  RecipeViewModel() {
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    _isLoading = true;
    notifyListeners();

    _recipes = await _recipeRepository.fetchRecipes();
    _isLoading = false;
    notifyListeners();
  }
}
