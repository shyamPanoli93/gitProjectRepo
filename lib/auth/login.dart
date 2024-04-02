import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:product_management/assets.dart';
import 'package:product_management/auth/auth_repository.dart';
import 'package:product_management/common/widget.dart';

class LoginSignUpScreen extends StatefulWidget {
  bool showLogin = false;

  LoginSignUpScreen({super.key, required this.showLogin});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  //bool showLogin = true; // true for login, false for signup
  String email = "", password = "", name = "";
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var autoValidate = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

  validate(String value, String type) {
    if (type == "username") {
      if (value.isEmpty) {
        return "username_validation".tr();
      }
    } else if (type == "password") {
      if (value.isEmpty) {
        return "password_validation".tr();
      }
    }
    return null;
  }

  signUpUser() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:   Text(
          'Registered Successfully',
          style: TextStyle(fontSize: 20),
        )));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-Password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
              content: Text(
            'Passsword Provide too weak',
            style: TextStyle(fontSize: 20),
          )));
        }else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Passsword Provide too weak',
                style: TextStyle(fontSize: 20),
              )));
        }
      }
    }
  }

/* Text("Let's ${widget.showLogin ? 'Sign In' : 'SignUp'}",
            style: const TextStyle(fontSize: 20, color: Color(0xff556A7F)))*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: "Let's ",
              style: const TextStyle(color: Colors.black, fontSize: 20),
              children: [
                widget.showLogin
                    ? TextSpan(
                        text: 'SignIn',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.robotoCondensed()
                                .fontFamily) //Color(0xff556A7F)
                        )
                    : TextSpan(
                        text: 'SignUp',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                GoogleFonts.robotoCondensed().fontFamily))
              ]),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Lottie.asset(loginBg, fit: BoxFit.cover),
              // Your form fields will go here
              (widget.showLogin) ? _buildLoginForm() : _buildSignupForm(),
              // Toggle button
              TextButton(
                child: Text(
                  widget.showLogin
                      ? "Don't have an account? Sign up"
                      : "Have an account? Log in",
                ),
                onPressed: () {
                  setState(() {
                    usernameController.text = "";
                    passwordController.text = "";
                    widget.showLogin = !widget.showLogin;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.only(
          start: 20, end: 20, bottom: 32, top: 16),
      child: Form(
        autovalidateMode: autoValidate,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: usernameController,
                maxLines: 1,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color(0xffC4D1DB), fontSize: 14),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.password,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xffC4D1DB), fontSize: 14),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            fullWidthPrimaryButton(context, () => () {}, 'Login'),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.only(
          start: 20, end: 20, bottom: 32, top: 16),
      child: Form(
        autovalidateMode: autoValidate,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: usernameController,
                maxLines: 1,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color(0xffC4D1DB), fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.password,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xffC4D1DB), fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            fullWidthPrimaryButton(context, () => signUpUser(), 'SignUp'),
          ],
        ),
      ),
    );
  }
}
