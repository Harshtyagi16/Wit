import 'package:flutter/material.dart';
import 'package:wit/screens/addRecipeScreen.dart';
import 'package:wit/screens/home.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;

  List<Widget> routes = [Home(), AddRecipe(), Text('a')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
          },
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.green.withOpacity(0.3),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
          ]),
      body: routes.elementAt(currentIndex),
    );
  }
}
