import 'package:flutter/material.dart';
import 'package:product_management/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child:  Image.asset(appLogo),
              ),
              Text("Production Manager",style: Theme.of(context).textTheme.headlineMedium,)
            ],
          ),
        ),
      ),
    );
  }
}
