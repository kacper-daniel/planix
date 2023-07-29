import 'package:flutter/material.dart';
import 'package:robocza_nazwa/routes/routes.dart';

class NavigationItem extends StatefulWidget {
  final String title;
  final Icon icon;
  final String routeName;
  final bool selected;
  final Function? onHighlight;

  const NavigationItem({super.key, required this.title, required this.routeName, required this.selected, this.onHighlight, required this.icon});

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 62,
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: (){
          navKey.currentState?.pushNamed(widget.routeName);
          if (widget.onHighlight != null){
            widget.onHighlight!(widget.routeName);
          }
          Scaffold.of(context).closeDrawer();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              widget.icon,
              Text(
                widget.title,
                style: widget.selected ? TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).colorScheme.primary) : TextStyle(fontSize: 12.0, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}