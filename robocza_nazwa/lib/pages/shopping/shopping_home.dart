// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';

class ShoppingHome extends StatefulWidget {
  const ShoppingHome({super.key});

  @override
  State<ShoppingHome> createState() => _ShoppingHomeState();
}

class _ShoppingHomeState extends State<ShoppingHome> {
  List<String> _savedShoppingList = UserSimplePreferences.getShoppingList() ?? [];
  TextEditingController newElementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: (_savedShoppingList.isEmpty) 
            ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: const Center(child: Text("Nothing to show here", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),))
            )
            : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _savedShoppingList.length,
              itemBuilder: (BuildContext context, int index){
                return Dismissible(
                  key: UniqueKey(), 
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        if (_savedShoppingList[index].split(";")[1] == 'true'){
                          _savedShoppingList[index] = "${_savedShoppingList[index].split(";")[0]};false";
                        } else{
                          _savedShoppingList[index] = "${_savedShoppingList[index].split(";")[0]};true";
                        }

                        UserSimplePreferences.setShoppingList(_savedShoppingList);
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _savedShoppingList[index].split(";")[1] == 'true' ? true : false, 
                              onChanged: (bool? value){
                                setState(() {
                                  _savedShoppingList[index] = "${_savedShoppingList[index].split(";")[0]};${value.toString()}";
                                  UserSimplePreferences.setShoppingList(_savedShoppingList);
                                });
                              },
                              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                return Colors.red;
                              })
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(_savedShoppingList[index].split(";")[0].toString(), style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      _savedShoppingList.removeAt(index);
                      UserSimplePreferences.setShoppingList(_savedShoppingList);
                    });
                  },
                );
              }
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
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
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return newElementDialog();
                          }
                        );
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, bottom: 12),
                child: Container(
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
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(                   
                      onTap: () {
                        //TODO: implement going to shopping list with selected items
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget newElementDialog(){
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))
      ),
      content: SizedBox(
        height: 100,
        child: Center(
          child: TextFormField(
            controller: newElementController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter new item',
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary,)),
            IconButton(onPressed: (){
              if (newElementController.text != ""){
                setState(() {
                  _savedShoppingList.add("${newElementController.text};false");
                  UserSimplePreferences.setShoppingList(_savedShoppingList);
                  newElementController.text = "";
                });
                Navigator.of(context).pop();
              } else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid input")));
              }
            }, icon: Icon(Icons.done, color: Theme.of(context).colorScheme.primary,))
          ],
        )
      ],
    );
  }
}