// ignore_for_file: body_might_complete_normally_nullable, dead_code

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:robocza_nazwa/pages/budget/budget_home.dart';
import 'package:robocza_nazwa/pages/other/app_info.dart';
import 'package:robocza_nazwa/pages/other/other_home.dart';
import 'package:robocza_nazwa/pages/other/settings.dart';
import 'package:robocza_nazwa/pages/other/simple_todo.dart';
import 'package:robocza_nazwa/pages/recipes/recipe_details.dart';
import 'package:robocza_nazwa/pages/recipes/recipes_home.dart';
import 'package:robocza_nazwa/pages/shopping/shopping_active_list.dart';
import 'package:robocza_nazwa/routes/routes.dart';
import 'package:robocza_nazwa/pages/shopping/shopping_home.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeShopping:
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          settings: settings,
          pageBuilder: (_, __, ___) => const ShoppingHome()
        );
        break;
      case routeRecipes:
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          settings: settings,
          pageBuilder: (_, __, ___) => const RecipesHome()
        );
        break;
      case routeBudget:
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          settings: settings,
          pageBuilder: (_, __, ___) => const BudgetHome()
        );
        break;
      case routeOther:
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          settings: settings,
          pageBuilder: (_, __, ___) => const OtherHome()
        );
        break;
      case routeActiveShoppingList:
        return PageTransition(
          child: const ShoppingActiveList(), 
          settings: settings,
          type: PageTransitionType.rightToLeftWithFade
        );
        break;
      case routeRecipeDetails:
        return PageTransition(
          child: const RecipeDetails(), 
          settings: settings,
          type: PageTransitionType.rightToLeftWithFade
        );
        break;
      case routeToDo:
        return PageTransition(
          child: const SimpleToDoList(), 
          settings: settings,
          type: PageTransitionType.fade
        );
        break;
      case routeSettings:
        return PageTransition(
          child: const Settings(), 
          settings: settings,
          type: PageTransitionType.fade
        );
        break;
      case routeInfo:
        return PageTransition(
          child: const AppInfo(), 
          settings: settings,
          type: PageTransitionType.rightToLeftWithFade
        );
        break;
    } 
  }
}