import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';

class BudgetHome extends StatefulWidget {
  const BudgetHome({super.key});

  @override
  State<BudgetHome> createState() => _BudgetHomeState();
}

class _BudgetHomeState extends State<BudgetHome> {
  List<String> savedWeeklyBudget = UserSimplePreferences.getWeeklyBudget() ?? [];
  List<String> savedMonthlyBudget = UserSimplePreferences.getMonthlyBudget() ?? [];
  List<String> savedYearlyBudget = UserSimplePreferences.getYearlyBudget() ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text("Weekly"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
            )
          ],
        ),
        const Divider(color: Colors.black,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: savedWeeklyBudget.length,
          itemBuilder: (BuildContext context, int index){
            return const Text("");
          }
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("Monthly"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
            )
          ],
        ),
        const Divider(color: Colors.black,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: savedMonthlyBudget.length,
          itemBuilder: (BuildContext context, int index){
            return const Text("");
          }
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("Yearly"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
            )
          ],
        ),
        const Divider(color: Colors.black,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: savedYearlyBudget.length,
          itemBuilder: (BuildContext context, int index){
            return const Text("");
          }
        ),
      ],
    );
  }
}