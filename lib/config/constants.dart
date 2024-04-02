import 'package:flutter/material.dart';
const kScaffoldBgColor = Color(0xFFF8F9FB);

const kTextColor = Color(0xFF081731);
const kAppBarIconColor = Colors.black87;
const kAppBarTextColor = Colors.black87;

const List<String> toggleSwitchLabel = ['Yes', 'No', 'Na'];

const navIconUnselectedColor = Color(0xFF0c2c66);

const internetError = "No internet connection";


bool isLoggedApp = false;


final cardPadding = EdgeInsets.all(16);
final cardMargin = EdgeInsetsDirectional.only(top: 8, start: 16, end: 8);
final cardDecoration = BoxDecoration(
    boxShadow: homeCardsBoxShadow,
    color: Colors.white,
    borderRadius: BorderRadius.circular(20));

List<BoxShadow> homeCardsBoxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    spreadRadius: -2,
    blurRadius: 2,
    offset: const Offset(0, 5),
  ),
];

var colors = [
  Color(0xFFff8000),
  Color(0xFF0080ff),
  Color(0xFFff0080),
  Color(0xFFA569BD),
  Color(0xFF85929E),
  Color(0xFF229954),
];

const kPrimaryColor = MaterialColor(
  0xFF0E93E1,
  <int, Color>{
    50: Color(0x8092d2b8),
    100: Color(0xFF0E93E1),
    200: Color(0xFF0E93E1),
    300: Color(0xFF0E93E1),
    400: Color(0xFF0E93E1),
    500: Color(0xFF0E93E1),
    600: Color(0xFF0E93E1),
    700: Color(0xFF0E93E1),
    800: Color(0xFF0E93E1),
    900: Color(0xFF0E93E1),
  },
);
const MaterialColor kSecondaryColor = MaterialColor(
  0xFF1ED1FF,
  <int, Color>{
    50: Color(0x801ED1FF),
    100: Color(0xFF1ED1FF),
    200: Color(0xFF1ED1FF),
    300: Color(0xFF1ED1FF),
    400: Color(0xFF1ED1FF),
    500: Color(0xFF1ED1FF),
    600: Color(0xFF1ED1FF),
    700: Color(0xFF1ED1FF),
    800: Color(0xFF1ED1FF),
    900: Color(0xFF1ED1FF),
  },
);

var kPrimaryColorAccent = kPrimaryColor.shade50;

var outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: const BorderSide(color: Colors.white),
  gapPadding: 10,
);

var focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: const BorderSide(color: Colors.white),
  gapPadding: 10,
);
