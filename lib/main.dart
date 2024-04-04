
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/app.dart';
import 'package:product_management/route.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Production',
      theme: theme(),
      routes: routes,
      navigatorKey: ProductionApp.materialKey,
      initialRoute: Routes.splashScreen,
    );
  }
}