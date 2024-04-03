
import 'package:flutter/material.dart';
import 'package:product_management/auth/login/view/loginScree.dart';
import 'package:product_management/auth/login/view/pin_log_registration.dart';
import 'package:product_management/auth/signUp/view/signUpScreen.dart';
import 'package:product_management/production/home/view/production_home.dart';
import 'package:product_management/splash_screen.dart';
import 'package:product_management/welcome_screen.dart';


final Map<String, WidgetBuilder> routes = {
  Routes.splashScreen: (context) => const SplashScreen(),
  Routes.welcomeScreen: (context) => const WelcomeScreen(),
  Routes.loginScreen: (context) => const LoginScreen(),
  Routes.signUpScreen: (context) => const SignUpScreen(),
  Routes.pinLoginRegisterScreen: (context) => PinLoginPage(),
  Routes.homeScreen: (context) => const HomeScreen(),
};

class Routes{
  static const String splashScreen = '/splashScreen';
  static const String welcomeScreen = '/welcomeScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String pinLoginRegisterScreen = '/pinLoginRegisterScreen';
  static const String homeScreen = '/homeScreen';
}