import 'package:flutter/material.dart';
import 'package:robocza_nazwa/widgets/bottom_nav_bar.dart';

class AppView extends StatefulWidget {
  final Widget child;

  const AppView({super.key, required this.child});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Container(child: widget.child)
              ),
            ],
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      ),
    );
  }
}