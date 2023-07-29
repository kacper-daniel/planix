import 'package:flutter/material.dart';

class ShoppingHome extends StatefulWidget {
  const ShoppingHome({super.key});

  @override
  State<ShoppingHome> createState() => _ShoppingHomeState();
}

class _ShoppingHomeState extends State<ShoppingHome> {
  List<int> items = List<int>.generate(10, (int index) => index);
  List<bool> checked = List<bool>.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: (items.isEmpty) ? const Text("Nothing to show here")
            : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index){
                return Dismissible(
                  key: ValueKey(items[index]), 
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        if (checked[index]){
                        checked[index] = false;
                        } else{
                          checked[index] = true;
                        }
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("${items[index]}", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
                            ),
                            Checkbox(
                              value: checked[index], 
                              onChanged: (bool? value){
                                setState(() {
                                  checked[index] = value!;
                                });
                              },
                              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                return Colors.red;
                              })
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      items.removeAt(index);
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
                        //TODO: implement adding new elemnt to list
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
}