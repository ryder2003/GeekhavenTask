import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travelling_geeks_latest/api/apis.dart';
import 'package:travelling_geeks_latest/features/map.dart';
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
  late MapScreen map;
  late Settings settings;
  late ProfileScreen profile;
  int currentTabIndex=0;
  bool _isInitialized = false; // Add a flag to track initialization

  @override
  void initState() {
    super.initState();
    // Initialize the user info and setup the screens
    _initialize();
  }

  Future<void> _initialize() async {
    await APIs.getSelfInfo(); // Ensure APIs.me is initialized
    setState(() {
      homescreen = HomeScreen();
      map = MapScreen();
      settings = Settings();
      profile = ProfileScreen(user: APIs.me,);
      Pages = [homescreen, map, profile, settings];
      _isInitialized = true; // Set the flag to true when initialization is complete
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [

          Icon(Icons.home_outlined, color: Colors.white,),

          Icon(Icons.location_on,color: Colors.white,),

          Icon(Icons.person_outlined, color: Colors.white,),

          Icon(Icons.settings, color: Colors.white,),
        ],),
      body: Pages[currentTabIndex],
    );
  }
}