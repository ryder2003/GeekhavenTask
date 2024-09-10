import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travelling_geeks_latest/screens/homescreen.dart';
import 'package:travelling_geeks_latest/screens/profile.dart';
import 'package:travelling_geeks_latest/screens/settings.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {

  late List<Widget> Pages;

  late HomeScreen homescreen;

  late Settings settings;
  late Profile profile;
  int currentTabIndex=0;
  //
  @override
  void initState() {
    settings = Settings();
    homescreen = HomeScreen();
    profile = Profile();
    Pages = [homescreen,  profile, settings];
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: const Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [

          Icon(Icons.home_outlined, color: Colors.white,),

          Icon(Icons.person_outlined, color: Colors.white,),

          Icon(Icons.settings, color: Colors.white,),
        ],),
      body: Pages[currentTabIndex],
    );
  }
}