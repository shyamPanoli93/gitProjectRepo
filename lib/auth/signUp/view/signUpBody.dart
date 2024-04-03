import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:product_management/auth/login/loginCubit/login_cubit.dart';
import 'package:product_management/auth/login/state/login_state_enum.dart';
import 'package:product_management/auth/signUp/cubit/signupCubit.dart';
import 'package:product_management/auth/signUp/state/signUpState.dart';
import 'package:product_management/common/widget.dart';

import '../../../assets.dart';
import '../../../route.dart';

class SignUpBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text:const TextSpan(
              text: "Let's ",
              style:  TextStyle(color: Colors.black, fontSize: 20),
              children: [
                TextSpan(
                    text: 'SignUp',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ))
              ]),
        ),

      ),
      body: BlocListener<SignUpCubit, SignUpState?>(
        listener: (context, state) {
          if (state?.type == SignUpStateType.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  snackBarWhenFailure(snackBarFailureText: "${state?.errorMessage}")
              );
          }else if(state?.type == SignUpStateType.success){
            ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess());
            Navigator.pushNamed(context, Routes.loginScreen);
          }else if(state?.type == SignUpStateType.invalidEmail){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  snackBarWhenFailure(snackBarFailureText: 'Invalid Email,Enter valid email')
              );
          }else if(state?.type == SignUpStateType.invalidPassword){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  snackBarWhenFailure(snackBarFailureText: 'Please enter valid password ')
              );
          }
        },
        child: BlocBuilder<SignUpCubit, SignUpState?>(
          builder: (context, state) {
            return const AuthenticationScreen();
          },
        ),
      ) ,
    );
  }
}

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> _willPopCallback() async {
    Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.welcomeScreen,
        ModalRoute.withName("/")
    );
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<SignUpCubit>();
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(loginBg, fit: BoxFit.cover),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(Icons.account_circle_sharp,color: Colors.grey,),
                        labelText: 'Email',
                        labelStyle:
                        TextStyle(color: Color(0xffC4D1DB), fontSize: 14),
                        alignLabelWithHint: true,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE2E2E2)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE2E2E2)),
                        ),
                        border: null,
                        fillColor: Colors.transparent,
                        filled: true),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(Icons.key,color: Colors.grey,),
                        labelText: 'Password',
                        labelStyle:
                        TextStyle(color: Color(0xffC4D1DB), fontSize: 14),
                        alignLabelWithHint: true,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE2E2E2)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE2E2E2)),
                        ),
                        border: null,
                        fillColor: Colors.transparent,
                        filled: true),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30.0),
                  fullWidthPrimaryButton(context, () => authCubit.signUp(emailController.text, passwordController.text), 'SignUp'),
                  const SizedBox(height: 20.0),
                  TextButton(
                    child: const Text("Already have an account? Login"),
                    onPressed: () {
                      setState(() {
                        emailController.text = "";
                        passwordController.text = "";
                        Navigator.pushNamed(context, Routes.loginScreen);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

