import 'package:flutter/material.dart';
import 'package:robocza_nazwa/widgets/bottom_nav_bar.dart';

class AppView extends StatelessWidget {
  final Widget child;

  const AppView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(child: child)
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}