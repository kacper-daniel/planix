import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget {
  final bool isSelected;
  final String text;

  const CategoryContainer({super.key, required this.isSelected, required this.text});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);

    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: (widget.isSelected ? Border.all(color: Colors.green) : Border.all(color: Colors.white)),
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [BoxShadow(color: (mode == ThemeData.dark()) ? Colors.white54 : Colors.black54, blurRadius: 3.5, spreadRadius: 0.1)]
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0)),
        ),
      ),
    );
  }
}