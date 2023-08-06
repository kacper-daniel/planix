import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;

  static const _keyShoppingList = "shoppingList";
  static const _keyRecipeList = "recipeList";
  static const _keyToDoList = "toDoList";

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setShoppingList(List<String> shoppingList) async =>
    await _preferences.setStringList(_keyShoppingList, shoppingList);

  static List<String>? getShoppingList() => _preferences.getStringList(_keyShoppingList);

  static Future setRecipeList(List<String> recipeList) async =>
    await _preferences.setStringList(_keyRecipeList, recipeList);

  static List<String>? getRecipeList() => _preferences.getStringList(_keyRecipeList);

  static Future setToDoList(List<String> toDoList) async =>
    await _preferences.setStringList(_keyToDoList, toDoList);

  static List<String>? getToDoList() => _preferences.getStringList(_keyToDoList);
}