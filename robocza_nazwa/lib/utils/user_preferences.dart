import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;

  static const _keyShoppingList = "shoppingList";

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setShoppingList(List<String> shoppingList) async =>
    await _preferences.setStringList(_keyShoppingList, shoppingList);

  static List<String>? getShoppingList() => _preferences.getStringList(_keyShoppingList);
}