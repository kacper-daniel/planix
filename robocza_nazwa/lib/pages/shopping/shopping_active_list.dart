import 'package:flutter/material.dart';

class ShoppingActiveList extends StatefulWidget {
  const ShoppingActiveList({super.key});

  @override
  State<ShoppingActiveList> createState() => _ShoppingActiveListState();
}

class _ShoppingActiveListState extends State<ShoppingActiveList> {
  late List<String>? activeList;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List<String>;
    activeList = arguments;
    return Column(
      children: [
        (activeList == null) ? SizedBox(height: MediaQuery.of(context).size.height * 0.75,) 
        : SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: activeList!.length,
            itemBuilder: (BuildContext context, index) {
              return Dismissible(
                key: UniqueKey(), 
                child: Card(
                  child: Text(activeList![index].toString().split(";")[0]),
                )
              );
            }
          ),
        )
      ],
    );
  }
}