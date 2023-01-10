import 'package:bluetooth_app/screens/spalsh.dart';
import 'package:bluetooth_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlueTooth app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
          headline2: GoogleFonts.montserrat(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
          bodyText2: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w400),
          bodyText1: GoogleFonts.montserrat(
              fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w400),
          subtitle1: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
          subtitle2:
              GoogleFonts.montserrat(fontSize: 16, color: Colors.black54),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
