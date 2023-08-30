import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/calculate_balance_from_list.dart';
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

  late double weeklySum;
  late double monthlySum;
  late double yearlySum;

  final _budgetFormKey = GlobalKey<FormState>();

  List<String> timeTypeItems = ['Weekly', 'Monthly', 'Yearly'];
  String timeTypeDropdownValue = 'Weekly';

  TextEditingController newElementController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  void updateBalances(){
    weeklySum = calculatedBalanceFromList(savedWeeklyBudget);
    monthlySum = calculatedBalanceFromList(savedMonthlyBudget) + (weeklySum * 4);
    yearlySum = calculatedBalanceFromList(savedYearlyBudget) + (monthlySum * 12);
  }

  @override
  void initState() {
    updateBalances();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Container(
              decoration:  const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.1)]),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .07,
                child: Form(
                  key: _budgetFormKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            validator: (value){
                              if (value == null){
                                return "Please enter some text";
                              } else{
                                return null;
                              }
                            },
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            controller: newElementController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'New item',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .15,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
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
                      ),
                      DropdownButton(
                        menuMaxHeight: 1000,
                        alignment: Alignment.bottomCenter,
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
                      Material(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          onTap: () {
                            if (_budgetFormKey.currentState!.validate()){
                              if (timeTypeDropdownValue == "Weekly"){
                                savedWeeklyBudget.add("${newElementController.text};${valueController.text};Weekly");
                                UserSimplePreferences.setWeeklyBudgetList(savedWeeklyBudget);
                              } else if (timeTypeDropdownValue == "Monthly"){
                                savedMonthlyBudget.add("${newElementController.text};${valueController.text};Monthly");
                                UserSimplePreferences.setMonthlyBudgetList(savedMonthlyBudget);
                              } else {
                                savedYearlyBudget.add("${newElementController.text};${valueController.text};Yearly");
                                UserSimplePreferences.setYearlyBudgetList(savedYearlyBudget);
                              }
                              updateBalances();
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
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text("Weekly"),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 4.0),
                    child: Text(weeklySum.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                    child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
                  ),
                ],
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
                          updateBalances();
                          setState(() {});
                        }, icon: const Icon(Icons.delete), iconSize: 16,),
                        const VerticalDivider(color: Colors.black,),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(monthlySum.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
                  ),
                ],
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
                          updateBalances();
                          setState(() {});
                        }, icon: const Icon(Icons.delete), iconSize: 16,),
                        const VerticalDivider(color: Colors.black,),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(yearlySum.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(UserSimplePreferences.getCurrencyType() ?? "PLN"),
                  ),
                ],
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
                          updateBalances();
                          setState(() {});
                        }, icon: const Icon(Icons.delete), iconSize: 16,),
                        const VerticalDivider(color: Colors.black,), 
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
        ],
      ),
    );
  }
}