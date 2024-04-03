import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:product_management/assets.dart';
import 'package:product_management/utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/widget.dart';
import '../../../route.dart';

class PinLoginPage extends StatefulWidget {
  @override
  _PinLoginPageState createState() => _PinLoginPageState();
}

class _PinLoginPageState extends State<PinLoginPage> {
  bool _passwordVisible = false;
  final TextEditingController _pinController = TextEditingController();
  final String _pinKey = 'pin';

  showError() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          snackBarWhenFailure(snackBarFailureText: 'Please Enter Pin'));
  }
  Future<bool> _willPopCallback() async {
    Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.welcomeScreen,
        ModalRoute.withName("/")
    );
    return false; // return true if the route to be popped
  }


  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(pinLoginBg, fit: BoxFit.cover),
                const Text(
                  'Set PIN for your App Login',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
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
                TextField(
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
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pinController.text.isEmpty) {
                        showError();
                      } else {
                        SharedPreference().setStringValue(
                            SharedPrefKeys.pinLogged, _pinController.text);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                              snackBarWhenSuccess());
                        Navigator.pushNamed(context, Routes.loginScreen);
                      }
                    },
                    child: Text('Save'),
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
