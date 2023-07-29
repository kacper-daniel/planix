import 'package:flutter/material.dart';
import 'package:robocza_nazwa/app_view.dart';
import 'package:robocza_nazwa/routes/routes.dart';
import 'package:robocza_nazwa/routes/routes_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoboczaNazwa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 99, 155, 252))
      ),
      builder: (_, child) => AppView(
        child: child!,
      ),
      initialRoute: routeShopping,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}