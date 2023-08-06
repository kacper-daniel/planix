import 'package:flutter/material.dart';

class OtherHome extends StatefulWidget {
  const OtherHome({super.key});

  @override
  State<OtherHome> createState() => _OtherHomeState();
}

class _OtherHomeState extends State<OtherHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushReplacementNamed("/toDo");
          },
          child: const Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: Center(child: Text("Simple To-Do list", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),))
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushReplacementNamed("/settings");
          },
          child: const Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: Center(child: Text("Settings", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),))
              ),
            ),
          ),
        )
      ],
    );
  }
}