import 'package:flutter/material.dart';
import 'package:robocza_nazwa/routes/routes.dart';
import 'package:robocza_nazwa/widgets/navigation_item.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
        boxShadow: [
          BoxShadow(
            color: (mode == ThemeData.dark()) ? Colors.white54 : Colors.black54,
            blurRadius: 6.0,
            offset: const Offset(0.0, 0.75)
          )
        ],
        color: Theme.of(context).colorScheme.background
      ),
      child: Row(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavigationItem(title: "Shopping list", icon: Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.primary), routeName: routeShopping, selected: index == 0, onHighlight: onHighlight,),
                NavigationItem(title: "Recipes", icon: Icon(Icons.dinner_dining, color: Theme.of(context).colorScheme.primary), routeName: routeRecipes, selected: index == 1, onHighlight: onHighlight),
                NavigationItem(title: "Budget", icon: Icon(Icons.monetization_on_outlined, color: Theme.of(context).colorScheme.primary), routeName: routeBudget, selected: index == 2, onHighlight: onHighlight),
                NavigationItem(title: "Other", icon: Icon(Icons.list, color: Theme.of(context).colorScheme.primary), routeName: routeOther, selected: index == 3, onHighlight: onHighlight),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onHighlight(String route) {
    switch (route) {
      case routeShopping:
        changeHighlight(0);
        break;
      case routeRecipes:
        changeHighlight(1);
        break;
      case routeBudget:
        changeHighlight(2);
        break;
      case routeOther:
        changeHighlight(3);
        break;
    }
  }

  void changeHighlight(int newIndex){
    setState(() {
      index = newIndex;
    });
  }
}