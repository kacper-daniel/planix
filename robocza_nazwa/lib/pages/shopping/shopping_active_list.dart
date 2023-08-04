import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';

class ShoppingActiveList extends StatefulWidget {
  const ShoppingActiveList({super.key});

  @override
  State<ShoppingActiveList> createState() => _ShoppingActiveListState();
}

class _ShoppingActiveListState extends State<ShoppingActiveList> {
  late List<String>? activeList;
  TextEditingController newElementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List<String>;
    activeList = arguments;
    return Stack(
      children: [ 
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: (activeList == null) ? SizedBox(height: MediaQuery.of(context).size.height * 0.75,) 
            : SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: activeList!.length,
                itemBuilder: (BuildContext context, index) {
                  return Dismissible(
                    key: UniqueKey(), 
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(activeList![index].toString().split(";")[0], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),),
                      ),
                    )
                  );
                }
              ),
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
                        var helper = UserSimplePreferences.getShoppingList();
                        if (helper != null){
                          for (int x = 0; x < helper.length; x++){
                            if (helper[x].split(";")[1] == "true"){
                              helper[x] = "${helper[x].split(";")[0]};false";
                            }
                          }
                          UserSimplePreferences.setShoppingList(helper);
                        }
                        setState(() {});
                        Navigator.of(context).pushReplacementNamed("/shopping");
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Icon(Icons.done, color: Colors.white)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]
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
                  activeList == null ? activeList = ["${newElementController.text};true"] : activeList!.add("${newElementController.text};true");
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