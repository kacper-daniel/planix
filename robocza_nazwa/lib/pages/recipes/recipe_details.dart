import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({super.key});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  List<String> savedRecipes = UserSimplePreferences.getRecipeList() ?? [];

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: const Icon(Icons.arrow_back_ios)),
            IconButton(onPressed: (){
              var helper = UserSimplePreferences.getRecipeList();
              helper!.removeAt(id);
              setState(() {
                UserSimplePreferences.setRecipeList(helper);
              });
              Navigator.of(context).pushReplacementNamed("/recipes");
            }, icon: const Icon(Icons.delete))
          ],
        ),
        Text(savedRecipes[id].split(";")[0]),
        Text(savedRecipes[id].split(";")[1]),
        Text(savedRecipes[id].split(";")[2])
      ],
    );
  }
}