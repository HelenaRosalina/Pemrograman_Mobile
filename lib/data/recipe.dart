import 'dart:convert';

class Recipe {
  final String title;
  final String image;
  final String summary;
  final List<String> ingredients;
  final String sourceName;
  final Map<String, bool> healthInfo;
  final List<String> instructions;

  Recipe({
    required this.title,
    required this.image,
    required this.summary,
    required this.ingredients,
    required this.sourceName,
    required this.healthInfo,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      summary: json['summary'] ?? '',
      ingredients: json['extendedIngredients'] != null
          ? (json['extendedIngredients'] as List)
          .map((ingredient) => ingredient['original'] as String)
          .toList()
          : [],
      sourceName: json['sourceName'] ?? '',
      healthInfo: {
        'vegetarian': json['vegetarian'] ?? false,
        'vegan': json['vegan'] ?? false,
        'glutenFree': json['glutenFree'] ?? false,
        'dairyFree': json['dairyFree'] ?? false,
        'veryHealthy': json['veryHealthy'] ?? false,
        'cheap': json['cheap'] ?? false,
        'veryPopular': json['veryPopular'] ?? false,
        'sustainable': json['sustainable'] ?? false,
        'lowFodmap': json['lowFodmap'] ?? false,
      },
      instructions: json['analyzedInstructions'] != null
          ? (json['analyzedInstructions'][0]['steps'] as List)
          .map((step) => step['step'] as String)
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'summary': summary,
      'ingredients': jsonEncode(ingredients),
      'sourceName': sourceName,
      'healthInfo': jsonEncode(healthInfo),
      'instructions': jsonEncode(instructions),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      summary: map['summary'] ?? '',
      ingredients: List<String>.from(jsonDecode(map['ingredients']) ?? []),
      sourceName: map['sourceName'] ?? '',
      healthInfo: Map<String, bool>.from(jsonDecode(map['healthInfo']) ?? {}),
      instructions: List<String>.from(jsonDecode(map['instructions']) ?? []),
    );
  }
}
