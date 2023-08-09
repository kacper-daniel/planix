import 'package:flutter/material.dart';
import 'package:robocza_nazwa/utils/user_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> currencyTypes = ['PLN', 'USD', 'EUR', 'GBP', 'CHF'];
  String dropdownValue = UserSimplePreferences.getCurrencyType() ?? "PLN";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Currency", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: DropdownButton(
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary
                ),
                value: dropdownValue,
                items: currencyTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(), 
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                    UserSimplePreferences.setCurrencyType(dropdownValue);
                  });
                }
              ),
            )
          ],
        )
      ],
    );
  }
}