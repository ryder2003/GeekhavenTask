import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling_geeks_latest/screens/nav.dart';
import 'modals/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
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
      home: const NavBar(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('es')
      ],
    );
  }
}
