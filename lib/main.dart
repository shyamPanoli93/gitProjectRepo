
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/app.dart';
import 'package:product_management/route.dart';
import 'package:product_management/utils/shared_preference.dart';

import 'common/constant.dart';
import 'config/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBSZ4nyhTAXSO_6zaeofhFtqOTDkaoznp4",
        appId: "1:381367853779:android:47c238f28d574588a92a26",
        messagingSenderId:"381367853779",
        projectId: "product-management-b48c3")
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<Null> getSharedPrefs() async {
    await SharedPreference()
        .getStringValue(SharedPrefKeys.pinLogged)
        .then(
          (value) {
        savedPin = value;
        print("SavedPin:........."+ savedPin);
      },
    );

  }


  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Production',
      theme: theme(),
      routes: routes,
      navigatorKey: ProductionApp.materialKey,
      initialRoute: savedPin.isEmpty?Routes.welcomeScreen:Routes.loginScreen,
    );
  }
}