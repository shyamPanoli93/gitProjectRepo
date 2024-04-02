import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
      ),
      primarySwatch: kPrimaryColor,
      unselectedWidgetColor: Colors.black,
      hintColor: kPrimaryColorAccent,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kScaffoldBgColor,
      fontFamily: "Poppins",
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      // inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: const ButtonThemeData(
        buttonColor: kPrimaryColor, //  <-- dark color
        textTheme:
            ButtonTextTheme.primary, //  <-- this auto selects the right color
      ));
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    backgroundColor: kScaffoldBgColor,
    elevation: 0,
    iconTheme: IconThemeData(color: kAppBarIconColor),
    titleTextStyle:  TextStyle(
        color: kAppBarTextColor, fontSize: 18, fontWeight: FontWeight.normal),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}
