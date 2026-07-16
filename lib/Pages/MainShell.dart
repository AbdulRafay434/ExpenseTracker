import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Mainshell extends StatelessWidget {
  final StatefulNavigationShell navshell;
  const Mainshell({super.key, required this.navshell});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: navshell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navshell.currentIndex,
        onTap: (index) =>  navshell.goBranch(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
          BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart_outlined),label: "stats")
        ],
      ),
    );
  }
}