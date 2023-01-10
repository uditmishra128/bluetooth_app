import 'package:bluetooth_app/screens/program.dart';
import 'package:bluetooth_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.pushNamed(context, ProgramScreen.routeName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(Constants.logo)),
    );
  }
}
