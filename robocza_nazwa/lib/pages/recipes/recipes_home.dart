// ignore_for_file: unused_field, prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';
import 'package:robocza_nazwa/widgets/category_container.dart';
import 'package:robocza_nazwa/widgets/recipe_preview_box.dart';

class RecipesHome extends StatefulWidget {
  const RecipesHome({super.key});

  @override
  State<RecipesHome> createState() => _RecipesHomeState();
}

class _RecipesHomeState extends State<RecipesHome> {
  List<String> categories = ['Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Other'];
  List<int> catSelected = [];

  List<String> _savedRecipeList = UserSimplePreferences.getRecipeList() ?? [];
  List<List<dynamic>> filteredRecipeList = [];

  TextEditingController recipeTitleController = TextEditingController();
  TextEditingController recipeDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<int> newRecipeCatSelected = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * .95,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: (){
                        if (catSelected.contains(index)){
                          catSelected.remove(index);
                        } else{
                          catSelected.add(index);
                        }

                        if (catSelected.isNotEmpty){
                          filteredRecipeList = [];
                          for(int i = 0; i < _savedRecipeList.length; i++){
                            List<String> helperCategories = _savedRecipeList[i].split(";")[1].split(",");
                            List<String> helperSelectedCategories = [];
                            for (int j = 0; j < catSelected.length; j++){
                              helperSelectedCategories.add(categories[catSelected[j]]);
                            }
                            bool added = false;
                            for (int j = 0; j < helperCategories.length; j++){
                              if (helperSelectedCategories.contains(helperCategories[j])){
                                if (!added){
                                  filteredRecipeList.add([_savedRecipeList[i], i]);
                                  added = true;
                                }
                              }
                            }
                          }
                        } else{
                          filteredRecipeList = [];
                        }

                        setState(() {});
                      },
                      child: CategoryContainer(isSelected: catSelected.contains(index), text: categories[index])
                    ),
                  );
                }
              ),
            ),
          ),
          const SizedBox(height: 16.0,),
          Expanded(
            child: (_savedRecipeList.isEmpty) ? const Center(child: Text("Nothing to show here", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),)
            : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: (catSelected.isEmpty) ? GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0, childAspectRatio: 1.75), 
                  itemCount: _savedRecipeList.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacementNamed('/recipeDetails', arguments: index);
                      },
                      child: RecipePreviewBox(title: _savedRecipeList[index].split(";")[0], category: _savedRecipeList[index].split(";")[1]),
                    );
                  })
                )
                : GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0), 
                  itemCount: filteredRecipeList.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacementNamed('/recipeDetails', arguments: filteredRecipeList[index][1]);
                      },
                      child: RecipePreviewBox(title: filteredRecipeList[index][0].split(";")[0], category: filteredRecipeList[index][0].split(";")[1]),
                    );
                  })
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black87,
                            offset: Offset(0, 1),
                            blurRadius: 2.0)
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        onTap: () {
                          var helper = [];
                          for (int i = 0; i < catSelected.length; i++){
                            helper.add(categories[catSelected[i]]);
                          }
                          var randomIndex = Random();

                          if(filteredRecipeList.isEmpty && catSelected.isEmpty){
                            showDialog(
                              context: context, 
                              builder: (BuildContext context){
                                return randomRecipeDialog(randomIndex.nextInt(_savedRecipeList.length), helper.join(", "));
                              }
                            );
                          } else if (filteredRecipeList.isNotEmpty){
                            showDialog(
                              context: context, 
                              builder: (BuildContext context){
                                return randomRecipeDialog(randomIndex.nextInt(filteredRecipeList.length), helper.join(", "));
                              }
                            );
                          } else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No recipes to choose from")));
                          }
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .5,
                          height: 40,
                          alignment: Alignment.center,
                          child: Text("Pick something for me!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Theme.of(context).colorScheme.background),),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0,),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black87,
                            offset: Offset(0, 1),
                            blurRadius: 2.0)
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context, 
                            builder: (BuildContext context){
                              return newRecipe();
                            }
                          );
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .2,
                          height: 40,
                          alignment: Alignment.center,
                          child: Icon(Icons.add, color: Theme.of(context).colorScheme.background,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // new recipe is saved in a string delimited by ";" and with this particular order:
  // [0] - Title
  // [1] - Categories
  // [2] - Description
  Widget newRecipe(){
    return AlertDialog(
      content: StatefulBuilder(
        builder: (context, setState){
          return SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .7,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value){
                      if (value == null){
                        return "Please enter some text";
                      } else{
                        return null;
                      }
                    },
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller: recipeTitleController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter title',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .8,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            if (newRecipeCatSelected.contains(index)){
                              newRecipeCatSelected.remove(index);
                              setState(() {});
                            } else{
                              newRecipeCatSelected.add(index);
                              setState(() {});
                            }
                          },
                          child: CategoryContainer(isSelected: newRecipeCatSelected.contains(index), text: categories[index])
                        ),
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .25),
                    child: SingleChildScrollView(
                      child: TextFormField(
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        controller: recipeDescriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,  
                        decoration: const InputDecoration.collapsed(hintText: "Enter recipe")
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },       
      ),
      actions: [
        IconButton(onPressed: (){
          setState(() {
            recipeTitleController.text = "";
            recipeDescriptionController.text = "";
            newRecipeCatSelected = [];
          });
          Navigator.of(context).pop();
        }, icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary,)),
        IconButton(onPressed: (){
          if (_formKey.currentState!.validate()){
            var helper = UserSimplePreferences.getRecipeList() ?? [];
            var helperCategories = [];
            for (int x = 0; x < newRecipeCatSelected.length; x++){
              helperCategories.add(categories[newRecipeCatSelected[x]]);
            }
            helper.add("${recipeTitleController.text};${helperCategories.join(",")};${recipeDescriptionController.text}");
            setState(() {
              recipeTitleController.text = "";
              recipeDescriptionController.text = "";
              newRecipeCatSelected = [];
              UserSimplePreferences.setRecipeList(helper);
              _savedRecipeList = UserSimplePreferences.getRecipeList() ?? [];
            });
            Navigator.of(context).pop();
          }
        }, icon: Icon(Icons.done, color: Theme.of(context).colorScheme.primary,))
      ]
    );
  }

  Widget randomRecipeDialog(int index, String selectedCategories){
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))
      ),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            const Text("From categories:", style: TextStyle(fontSize: 15),),

            (selectedCategories == "") 
            ? const Text("All", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),) 
            : Text(selectedCategories, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),

            const SizedBox(height: 16,),

            (filteredRecipeList.isEmpty && catSelected.isEmpty) 
            ? Text(_savedRecipeList[index].split(";")[0], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 26),) 
            : Text(filteredRecipeList[index][0].split(";")[0], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 26))
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context, 
                    builder: (BuildContext context){
                      var randomIndex = Random();
                      if (filteredRecipeList.isEmpty && catSelected.isEmpty){
                        return randomRecipeDialog(randomIndex.nextInt(_savedRecipeList.length), selectedCategories);
                      } else{
                        return randomRecipeDialog(randomIndex.nextInt(filteredRecipeList.length), selectedCategories);
                      }
                    }
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: MediaQuery.of(context).size.width * .3,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text("Try again", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Theme.of(context).colorScheme.background),),
                ),
              ),
            ),
            Material(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  if (filteredRecipeList.isEmpty && catSelected.isEmpty){
                    Navigator.of(context).pushReplacementNamed("/recipeDetails", arguments: index);
                  } else{
                    Navigator.of(context).pushReplacementNamed("/recipeDetails", arguments: filteredRecipeList[index][1]);
                  }
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: MediaQuery.of(context).size.width * .3,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text("Go to recipe", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Theme.of(context).colorScheme.background),),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}