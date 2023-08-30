// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';

class SimpleToDoList extends StatefulWidget {
  const SimpleToDoList({super.key});

  @override
  State<SimpleToDoList> createState() => _SimpleToDoListState();
}

class _SimpleToDoListState extends State<SimpleToDoList> {
  List<String> _savedToDoList = UserSimplePreferences.getToDoList() ?? [];
  TextEditingController newElementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: (_savedToDoList.isEmpty) 
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: const Center(child: Text("Nothing to show here", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),))
            )        
            : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _savedToDoList.length,
              itemBuilder: (BuildContext context, int index){
                return Dismissible(
                  key: UniqueKey(), 
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_savedToDoList[index], style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      _savedToDoList.removeAt(index);
                      UserSimplePreferences.setToDoList(_savedToDoList);
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
                padding: const EdgeInsets.all(16.0),
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
            autofocus: true,
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
                  _savedToDoList.add(newElementController.text);
                  UserSimplePreferences.setToDoList(_savedToDoList);
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