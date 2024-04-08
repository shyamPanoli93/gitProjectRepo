import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../route.dart';

Future<Future> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String message,
  required bool isFail
}) async {
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(message),
          onPressed: () =>  SnackBar(
            content: Text(isFail?message:"Success!"),
            backgroundColor: isFail?Colors.red:Colors.green,
          ),
        ),
      ],
    ),
  );
}