import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling_geeks_latest/screens/nav.dart';
import 'package:travelling_geeks_latest/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'modals/theme_provider.dart';

//Global object for accessing Screen Size
late Size mq;

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
      child: const MyApp()));
}
//test
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravellingGeeks',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
_initializeFirebase() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
