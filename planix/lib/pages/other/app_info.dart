import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text("App version: 1.0.0", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),
        ),
        DottedLine(lineThickness: 1.5, dashLength: 4.0,),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("• Shopping list", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(" You can add products that you buy periodically and mark whether you have them or they're out of stock/close to. \n Then with button in right bottom corner you can pass to a screen that contains a shopping list with products you selected and add some more if you want. \n If you dismiss from this list products previously marked they will become unmarked.", textAlign: TextAlign.justify,),
        ),
        SizedBox(height: 12.0,),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("• Food", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(' That\'s sort of a library for your recipes/food you like. \n With a "Pick something for me!" button you can draw one of them if you aren\'t sure what to eat', textAlign: TextAlign.justify,),
        ),
        SizedBox(height: 12.0,),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("• Budget", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(" A simple place for recording your recurring expenses and incomes", textAlign: TextAlign.justify,),
        ),
        SizedBox(height: 12.0,),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("• Other", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(" There you will find very simple to-do list as well as settings (and probably something more in the future - work in progress)", textAlign: TextAlign.justify,),
        )
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(Icons.copyright),
        //     Text("Kacper Daniel", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),)
        //   ],
        // )
      ],
    );
  }
}