import 'package:flutter/material.dart';

class RecipePreviewBox extends StatelessWidget {
  final String title;
  final String category;

  const RecipePreviewBox({super.key, required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    final icons = [
      const Icon(Icons.free_breakfast),
      const Icon(Icons.lunch_dining),
      const Icon(Icons.local_dining_rounded),
      const Icon(Icons.icecream),
      const Icon(Icons.question_mark),
      const Icon(Icons.diamond)
    ];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [BoxShadow(color: (mode == ThemeData.dark()) ? Colors.white54 : Colors.black54, blurRadius: 3.5, spreadRadius: 0.1)]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              category == "Breakfast" ? icons[0] : category == "Lunch" ? icons[1] : category == "Dinner" ? icons[2] : category == "Dinner" ? icons[3] : category.contains(",") ? icons[5] : icons[4],
              const SizedBox(width: 12.0,),
              Text(category.contains(",") ? "Universal" : category)
            ],
          )
        ],
      ),
    );
  }
}