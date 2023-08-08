import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("App version: 0.0.1", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),
        SizedBox(height: 12.0,),
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