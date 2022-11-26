import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/controller/RecipeP.dart';
import 'package:wit/typography.dart';

class DetailsScreen extends StatelessWidget {
  final int i;

  const DetailsScreen({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeProvider>(context).allRecipe[i];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.5),
        title: Text(recipe.recipeName),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('No of People can Be Served ${recipe.serve}'),
                verticalSpace(height: 10),
                const Text('Steps to be Followed are'),
                verticalSpace(height: 10),
                Text(recipe.stepsNote),
                verticalSpace(height: 20),
                const Text('Ingredients'),
                verticalSpace(height: 10),
                Text(recipe.ingredientNote),
              ]),
        ),
      ),
    );
  }
}
