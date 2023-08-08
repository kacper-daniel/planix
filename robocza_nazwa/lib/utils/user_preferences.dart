import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;

  static const _keyShoppingList = "shoppingList";
  static const _keyRecipeList = "recipeList";
  static const _keyToDoList = "toDoList";
  static const _keyWeeklyBudget = "weeklyBudget";
  static const _keyMonthlyBudget = "monthlyBudget";
  static const _keyYearlyBudget = "yearlyBudget";
  static const _keyCurrencyType = "currencyType";

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

  static Future setWeeklyBudgetList(List<String> weeklyBudget) async =>
    await _preferences.setStringList(_keyWeeklyBudget, weeklyBudget);

  static List<String>? getWeeklyBudget() => _preferences.getStringList(_keyWeeklyBudget);

  static Future setMonthlyBudgetList(List<String> monthlyBudget) async =>
    await _preferences.setStringList(_keyMonthlyBudget, monthlyBudget);

  static List<String>? getMonthlyBudget() => _preferences.getStringList(_keyMonthlyBudget);

  static Future setYearlyBudgetList(List<String> yearlyBudget) async =>
    await _preferences.setStringList(_keyYearlyBudget, yearlyBudget);

  static List<String>? getYearlyBudget() => _preferences.getStringList(_keyYearlyBudget);
  
  static Future setCurrencyType(String currencyType) async =>
    await _preferences.setString(_keyCurrencyType, currencyType);

  static String? getCurrencyType() => _preferences.getString(_keyCurrencyType);
}