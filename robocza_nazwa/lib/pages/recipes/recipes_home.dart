// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';
import 'package:robocza_nazwa/widgets/recipe_preview_box.dart';

class RecipesHome extends StatefulWidget {
  const RecipesHome({super.key});

  @override
  State<RecipesHome> createState() => _RecipesHomeState();
}

class _RecipesHomeState extends State<RecipesHome> {
  List<String> categories = ['Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Other'];
  List<int> catSelected = [];

  List<String> _savedRecipeList = UserSimplePreferences.getShoppingList() ?? [];

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);

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
                          setState(() {});
                        } else{
                          catSelected.add(index);
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: (catSelected.contains(index) ? Border.all(color: Colors.green) : Border.all(color: Colors.white)),
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.background,
                          boxShadow: [BoxShadow(color: (mode == ThemeData.dark()) ? Colors.white54 : Colors.black54, blurRadius: 3.5, spreadRadius: 0.1)]
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(categories[index], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0)),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
          Expanded(
            child: (_savedRecipeList.isEmpty) ? const Center(child: Text("Nothing to show here", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),)
            : SingleChildScrollView(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12.0, mainAxisSpacing: 12.0), 
                itemCount: _savedRecipeList.length,
                itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: (){
                        //TODO: implement going to recipe details
                      },
                      child: RecipePreviewBox(title: _savedRecipeList[index].split(";")[1], category: _savedRecipeList[index].split(";")[0]),
                    );
                })
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
                          //TODO: implement recipe randomizer
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
                          //TODO: implement adding new recipe
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
}