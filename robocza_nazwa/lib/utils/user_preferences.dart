import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;

  static const _keyShoppingList = "shoppingList";
  static const _keyRecipeList = "recipeList";

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setShoppingList(List<String> shoppingList) async =>
    await _preferences.setStringList(_keyShoppingList, shoppingList);

  static List<String>? getShoppingList() => _preferences.getStringList(_keyShoppingList);

  static Future setRecipeList(List<String> recipeList) async =>
    await _preferences.setStringList(_keyRecipeList, recipeList);

  static List<String>? getRecipeList() => _preferences.getStringList(_keyRecipeList);
}