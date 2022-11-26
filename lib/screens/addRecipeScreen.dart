import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wit/controller/RecipeP.dart';
import 'package:wit/model/recipe.dart';
import 'package:wit/screens/home.dart';
import 'package:wit/typography.dart';

import 'landingScreen.dart';

class AddRecipe extends StatefulWidget {
  AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  Duration? _prepDuration = Duration();
  Duration? _cookDuration = Duration();
  TextEditingController recipeName = TextEditingController();
  TextEditingController serve = TextEditingController();
  TextEditingController stepsNote = TextEditingController();
  TextEditingController ingredient = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.5),
        title: Text('Add Recipe'),
      ),
      body: Form(
        key: _form,
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(height: 20),
                Container(
                  height: size.height * 0.05,
                  width: size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text('Add Details'),
                ),
                verticalSpace(height: 20),
                TextFormField(
                  controller: recipeName,
                  decoration: InputDecoration(
                      hintText: 'Recipe Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                verticalSpace(height: 20),
                Chip(
                  label: Text('Serve'),
                ),
                verticalSpace(height: 6),
                TextFormField(
                  controller: serve,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'No.of Person Can be Served',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                verticalSpace(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      Text(
                        'Prep time',
                        style: GoogleFonts.lexendDeca(fontSize: 15),
                      ),
                      verticalSpace(height: 10),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple.withOpacity(0.3)),
                          child: Text(format(_prepDuration!).toString())),
                      verticalSpace(height: 10),
                      MaterialButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () async {
                          _prepDuration = (await showDurationPicker(
                              context: context, initialTime: _prepDuration!));
                          setState(() {});
                        },
                        child: Text('Add Time'),
                      )
                    ]),
                    Column(children: [
                      Text('Cook time',
                          style: GoogleFonts.lexendDeca(fontSize: 15)),
                      verticalSpace(height: 10),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple.withOpacity(0.3)),
                          child: Text(format(_cookDuration!).toString())),
                      verticalSpace(height: 10),
                      MaterialButton(
                        onPressed: () async {
                          _cookDuration = (await showDurationPicker(
                              context: context, initialTime: _cookDuration!));
                          setState(() {});
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Add Time'),
                      )
                    ]),
                  ],
                ),
                verticalSpace(height: 30),
                Chip(label: Text('Note on Steps')),
                verticalSpace(height: 6),
                TextFormField(
                  controller: stepsNote,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'Write a Note for Steps',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                verticalSpace(height: 30),
                Chip(label: Text('Ingredient to be added with quantity')),
                verticalSpace(height: 6),
                TextFormField(
                  controller: ingredient,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'Ingredients to be added with quantity',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                verticalSpace(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    color: Colors.green,
                    height: size.height * 0.06,
                    minWidth: size.width * 0.4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    onPressed: () async {
                      await recipeProvider.add(
                        Recipe(
                            recipeName: recipeName.text.trim(),
                            serve: int.parse(serve.text),
                            prepTime: _prepDuration!.toString(),
                            cookTime: _cookDuration!.toString(),
                            stepsNote: stepsNote.text.trim(),
                            ingredientNote: ingredient.text.trim()),
                      );

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LandingScreen()));
                    },
                    child: Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
