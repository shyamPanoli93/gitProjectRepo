
import 'package:flutter/material.dart';
import 'package:product_management/splashScreen.dart';
import 'package:product_management/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Routes.splashScreen: (context) => const SplashScreen(),
  Routes.welcomeScreen: (context) => const WelcomeScreen(),

};

class Routes{
  static const String splashScreen = '/splashScreen';
  static const String welcomeScreen = '/welcomeScreen';
}