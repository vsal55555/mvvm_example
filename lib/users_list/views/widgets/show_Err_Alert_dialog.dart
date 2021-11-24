

  import 'package:flutter/material.dart';

showErrAlertDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("GitHub"),
      content: Text('No Internet Connection. Please close and reopen the app.'),
    );

    // show the dialog
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
  }