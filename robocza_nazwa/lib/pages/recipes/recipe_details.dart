import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/category_icons.dart';
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
    String title = savedRecipes[id].split(";")[0];
    List<String> categories = savedRecipes[id].split(";")[1].split(",");
    String description = savedRecipes[id].split(";")[2];
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushReplacementNamed("/recipes");
            }, icon: const Icon(Icons.arrow_back_ios)),
            IconButton(onPressed: (){
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    title: const Text("Are you sure you want to delete this recipe?"),
                    actions: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: const Icon(Icons.close)),
                      IconButton(onPressed: (){
                        var helper = UserSimplePreferences.getRecipeList();
                        helper!.removeAt(id);
                        setState(() {
                          UserSimplePreferences.setRecipeList(helper);
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed("/recipes");
                      }, icon: const Icon(Icons.done))
                    ],
                  );
                }
              );
            }, icon: const Icon(Icons.delete))
          ],
        ),
        const Divider(color: Colors.black,),
        Padding(
          padding: const EdgeInsets.only(top: 16.0,),
          child: Text(title, style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              categories.length == 1 ? categories[0] == "Breakfast" ? icons[0] : categories[0] == "Lunch" ? icons[1] : categories[0] == "Dinner" ? icons[2] : categories[0] == "Dessert" ? icons[3] : categories[0] == "Other" ? icons[4] : icons[4] : icons[5],
              const SizedBox(width: 8.0,),
              categories.length == 1 ? Text(categories[0], style: const TextStyle(fontSize: 14),) : Text(categories.join("  |  "), style: const TextStyle(fontSize: 14))
            ], 
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          child: const DottedLine(dashLength: 6.0, lineThickness: 1.75,)
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(description, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))
          ),
        )
      ],
    );
  }
}