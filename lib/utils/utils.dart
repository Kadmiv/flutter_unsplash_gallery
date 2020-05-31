import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/connection_error_widget.dart';

Future<bool> isHaveConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}


void showConnectionErrorDialog(BuildContext context, Function action) {
  var dialog = AlertDialog(
    content: ConnectionErrorWidget(),
    actions: <Widget>[
      FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          action();
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
        child: Text(
          "Try again",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    ],
  );

  showDialog(context: context, builder: (_) => dialog);
}
