import 'package:bluetooth_app/screens/program.dart';
import 'package:bluetooth_app/screens/spalsh.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    String path = settings.name!;

    switch (path) {
      case SplashScreen.routeName:
        return PageTransition(
            child: const SplashScreen(),
            settings: settings,
            type: PageTransitionType.fade);
      case ProgramScreen.routeName:
        return PageTransition(
            child: const ProgramScreen(),
            settings: settings,
            type: PageTransitionType.fade);
      default:
        return PageTransition(
            child: const SplashScreen(),
            settings: settings,
            type: PageTransitionType.fade);
    }
  }
}
