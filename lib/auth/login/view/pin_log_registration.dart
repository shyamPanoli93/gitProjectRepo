import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:product_management/assets.dart';
import 'package:product_management/utils/shared_preference.dart';
import '../../../common/constant.dart';
import '../../../common/widget.dart';
import '../../../route.dart';

class PinLoginPage extends StatefulWidget {
  @override
  _PinLoginPageState createState() => _PinLoginPageState();
}

class _PinLoginPageState extends State<PinLoginPage> {
  bool _passwordVisible = false;
  final TextEditingController _pinController = TextEditingController();
  bool _isKeyboardVisible = false;
  final FocusNode _focusNode = FocusNode();

  showError() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          snackBarWhenFailure(snackBarFailureText: 'Please Enter Pin'));
  }

  Future<bool> _willPopCallback() async {
    isLoggedApp
        ? Navigator.pushNamedAndRemoveUntil(
            context, Routes.welcomeScreen, ModalRoute.withName("/"))
        : Navigator.pop(context);
    return false; // return true if the route to be popped
  }

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
        print("SavedPin:........." + savedPin);
      },
    );
  }

  setUpPin() {
    if (_pinController.text.isEmpty) {
      print("fail to Pin generation ---${_pinController.text}");
      showError();
    } else {
      print("Success to Pin generation ---${_pinController.text}");
      SharedPreference()
          .setStringValue(SharedPrefKeys.pinLogged, _pinController.text);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBarWhenSuccess());
      Navigator.pushNamed(context, Routes.homeScreen);
    }
  }

  loginApp() {
    if (savedPin.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            snackBarWhenFailure(snackBarFailureText: 'PIN is not set up'));
    } else if (savedPin == _pinController.text) {
      Navigator.pushNamed(context, Routes.homeScreen);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBarWhenFailure(snackBarFailureText: 'Invalid PIN'));
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    _passwordVisible = false;
    _focusNode.addListener(
      () => _onFocusChange,
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(
      () => _onFocusChange,
    );
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25.0),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _isKeyboardVisible
                        ? MediaQuery.of(context).size.height * 0.3
                        : MediaQuery.of(context).size.height * 0.5,
                    child: Lottie.asset(pinLoginBg, fit: BoxFit.cover)),
                const SizedBox(height: 30.0),
                Text(
                  savedPin.isNotEmpty
                      ? 'Enter your PIN for App Login'
                      : 'Set PIN for your App Login',
                  style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                      'Pin must be at least 4 digits,It must not be Single digits like 1111 or digits in numerical order such as 1234',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey)),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  focusNode: _focusNode,
                  controller: _pinController,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: 'Enter PIN',
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: !_passwordVisible,
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      savedPin.isNotEmpty ? loginApp() : setUpPin();
                    },
                    child: Text(savedPin.isNotEmpty ? 'Login' : 'Save',style: const TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
