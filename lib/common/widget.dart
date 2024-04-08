import 'package:flutter/material.dart';
import 'package:product_management/common/methods.dart';

import '../config/constants.dart';

Container fullWidthPrimaryButton(
    BuildContext context, Function() onClick, String label) {
  return Container(
    padding: const EdgeInsets.only(top: 16, bottom: 16),
    width: double.infinity,
    color: Colors.transparent,
    child: Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: onClick,
        child: Ink(
          padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
                stops: [0.0, 10.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kSecondaryColor,
                  kPrimaryColor,
                ]),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            constraints: const BoxConstraints(minWidth: 88.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

SnackBar snackBarWhenFailure({required String snackBarFailureText}) {
  return SnackBar(
    content: Text(snackBarFailureText),
    backgroundColor: Colors.red,
  );
}

SnackBar snackBarWhenSuccess() {
  return const SnackBar(
    content: Text("Success!"),
    backgroundColor: Colors.green,
  );
}


OutlineInputBorder requestFormBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: const BorderSide(color: Color(0xffDFE7F6), width: 1),
);

OutlineInputBorder leaveRequestBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: const BorderSide(color: Color(0xffDFE7F6), width: 1),
);
