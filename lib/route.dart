
import 'package:flutter/material.dart';
import 'package:product_management/auth/login/view/loginScree.dart';
import 'package:product_management/auth/login/view/pin_log_registration.dart';
import 'package:product_management/auth/login/view/pin_login.dart';
import 'package:product_management/auth/signUp/view/signUpScreen.dart';
import 'package:product_management/welcome_screen.dart';


final Map<String, WidgetBuilder> routes = {
  Routes.welcomeScreen: (context) => const WelcomeScreen(),
  Routes.loginScreen: (context) => const LoginScreen(),
  Routes.signUpScreen: (context) => const SignUpScreen(),
  Routes.pinLoginScreen: (context) => const PinLoginBody(),
  Routes.pinLoginRegisterScreen: (context) => PinLoginPage(),
};

class Routes{
  static const String welcomeScreen = '/welcomeScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String pinLoginScreen = '/pinLoginScreen';
  static const String pinLoginRegisterScreen = '/pinLoginRegisterScreen';
}