import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:product_management/assets.dart';
import 'package:product_management/route.dart';
import 'package:product_management/utils/shared_preference.dart';

import 'common/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Null> getSharedPrefs() async {
    await SharedPreference()
        .getBooleanValue(SharedPrefKeys.isLogged)
        .then((isLogged) {
      isLoggedApp = isLogged;
      log("IsLoggedItems:---$isLoggedApp");
    });

    await SharedPreference().getStringValue(SharedPrefKeys.pinLogged).then(
      (value) {
        savedPin = value;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(seconds: 2), () {
            if (isLoggedApp) {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(Routes.pinLoginRegisterScreen,
                      (Route<dynamic> route) => false);
            } else {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                      Routes.welcomeScreen, (Route<dynamic> route) => false);
            }
          });
        });
        print("SavedPin:........." + savedPin);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  appLogo,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'Production',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Manager',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
