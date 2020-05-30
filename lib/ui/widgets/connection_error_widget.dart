import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionErrorWidget extends StatelessWidget {
  Function tryAgainFunc;

  ConnectionErrorWidget(this.tryAgainFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 320,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/connection_error.png",
              width: 100,
              height: 100,
            ),
          ), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Connection error",
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Check internet on your device",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                tryAgainFunc();
              },
              child: Text(
                "Try again",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
