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

  late int weeklySum;
  late int monthlySum;
  late int yearlySum;

  final _budgetFormKey = GlobalKey<FormState>();

  List<String> balanceItems = ['+', '-'];
  String balanceDropdownValue = '+';
  List<String> timeTypeItems = ['Weekly', 'Monthly', 'Yearly'];
  String timeTypeDropdownValue = 'Weekly';

  TextEditingController newElementController = TextEditingController();
  TextEditingController valueController = TextEditingController();

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
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: savedWeeklyBudget.length,
              itemBuilder: (BuildContext context, int index){
                var helper = savedWeeklyBudget[index].split(";");
                return SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text((index + 1).toString()),
                      ),
                      const VerticalDivider(color: Colors.black,),
                      Text(helper[0]),
                      const Spacer(),
                      IconButton(onPressed: (){
                        savedWeeklyBudget.removeAt(index);
                        UserSimplePreferences.setWeeklyBudgetList(savedWeeklyBudget);
                        setState(() {});
                      }, icon: const Icon(Icons.delete), iconSize: 16,),
                      const VerticalDivider(color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(helper[3]),
                      ), 
                      SizedBox(
                        width: 40,
                        child: Text(helper[1])
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
                      ),                  
                    ],
                  ),
                );
              }
            ),
          ),
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
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: savedMonthlyBudget.length,
              itemBuilder: (BuildContext context, int index){
                var helper = savedMonthlyBudget[index].split(";");
                return SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text((index + 1).toString()),
                      ),
                      const VerticalDivider(color: Colors.black,),
                      Text(helper[0]),
                      const Spacer(),
                      IconButton(onPressed: (){
                        savedMonthlyBudget.removeAt(index);
                        UserSimplePreferences.setMonthlyBudgetList(savedMonthlyBudget);
                        setState(() {});
                      }, icon: const Icon(Icons.delete), iconSize: 16,),
                      const VerticalDivider(color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(helper[3]),
                      ), 
                      SizedBox(
                        width: 40,
                        child: Text(helper[1])
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
                      ),                  
                    ],
                  ),
                );
              }
            ),
          ),
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
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: savedYearlyBudget.length,
              itemBuilder: (BuildContext context, int index){
                var helper = savedYearlyBudget[index].split(";");
                return SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text((index + 1).toString()),
                      ),
                      const VerticalDivider(color: Colors.black,),
                      Text(helper[0]),
                      const Spacer(),
                      IconButton(onPressed: (){
                        savedYearlyBudget.removeAt(index);
                        UserSimplePreferences.setYearlyBudgetList(savedYearlyBudget);
                        setState(() {});
                      }, icon: const Icon(Icons.delete), iconSize: 16,),
                      const VerticalDivider(color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(helper[3]),
                      ), 
                      SizedBox(
                        width: 40,
                        child: Text(helper[1])
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
                      ),                  
                    ],
                  ),
                );
              }
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
          child: Form(
            key: _budgetFormKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: TextFormField(
                    validator: (value){
                      if (value == null){
                        return "Please enter some text";
                      } else{
                        return null;
                      }
                    },
                    autofocus: false,
                    controller: newElementController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'New item',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .15,
                  child: TextFormField(
                    validator: (value){
                      if (value == null){
                        return "Please enter some number";
                      } else{
                        return null;
                      }
                    },
                    autofocus: false,
                    controller: valueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: UserSimplePreferences.getCurrencyType() ?? "PLN"
                    ),
                  ),
                ),
                DropdownButton(
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.primary
                  ),
                  value: timeTypeDropdownValue,
                  items: timeTypeItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(), 
                  onChanged: (String? value) {
                    setState(() {
                      timeTypeDropdownValue = value!;
                    });
                  }
                ),
                DropdownButton(
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.primary
                  ),
                  value: balanceDropdownValue,
                  items: balanceItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(), 
                  onChanged: (String? value) {
                    setState(() {
                      balanceDropdownValue = value!;
                    });
                  }
                ),
                Material(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    onTap: () {
                      if (_budgetFormKey.currentState!.validate()){
                        if (timeTypeDropdownValue == "Weekly"){
                          savedWeeklyBudget.add("${newElementController.text};${valueController.text};Weekly;${balanceDropdownValue}");
                          UserSimplePreferences.setWeeklyBudgetList(savedWeeklyBudget);
                        } else if (timeTypeDropdownValue == "Monthly"){
                          savedMonthlyBudget.add("${newElementController.text};${valueController.text};Monthly;${balanceDropdownValue}");
                          UserSimplePreferences.setMonthlyBudgetList(savedMonthlyBudget);
                        } else {
                          savedYearlyBudget.add("${newElementController.text};${valueController.text};Yearly;${balanceDropdownValue}");
                          UserSimplePreferences.setYearlyBudgetList(savedYearlyBudget);
                        }
                        newElementController.text = "";
                        valueController.text = "";
                        setState(() {});
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid input")));
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(Icons.add, color: Theme.of(context).colorScheme.background,),
                    ),
                  ),
                ),
              ],
            )
          ),
        )
      ],
    );
  }
}