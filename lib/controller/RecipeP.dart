import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/controller/RecipeP.dart';
import 'package:wit/model/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeProvider with ChangeNotifier {
  final String? _tokenId;
  final String? _userId;

  RecipeProvider(this._tokenId, this._userId);

  List<Recipe> _allRecipe = [];

  List<Recipe> get allRecipe {
    return [..._allRecipe];
  }

  Future<void> add(Recipe recipe) async {
    final url = Uri.parse(
        "https://witt-5c651-default-rtdb.firebaseio.com/recipe/$_userId.json?auth=$_tokenId");
    try {
      final request = await http.post(url,
          body: jsonEncode({
            "recipeName": recipe.recipeName,
            "serve": recipe.serve,
            "prepTime": recipe.prepTime,
            "cookTime": recipe.cookTime,
            "steps" : recipe.stepsNote,
            "ingredient" : recipe.ingredientNote,
          }));
      print(request.body);
      print(request.statusCode);
    } catch (e) {}
  }

  Future<void> fetchRecipe() async {
    final url = Uri.parse(
        "https://witt-5c651-default-rtdb.firebaseio.com/recipe/$_userId.json?auth=$_tokenId");

    try {
      final response = await http.get(url);
      final extractedRecipe =
          jsonDecode(response.body) as Map<String, dynamic>?;
      final List<Recipe> loadedRecipe = [];
      print(json.decode(response.body));
      print(extractedRecipe);
      if (extractedRecipe == null) {
        print("NO DATA AVAILABLE");
        return;
      }
      extractedRecipe.forEach((key, value) {
        loadedRecipe.add(Recipe(
            recipeName: value["recipeName"],
            serve: value["serve"],
            prepTime: value["prepTime"],
            cookTime: value["cookTime"],
        stepsNote: value["steps"],
          ingredientNote: value["ingredient"],
        ));
      });
      _allRecipe = loadedRecipe.toList();
      notifyListeners();
    } catch (e) {}
  }
}
