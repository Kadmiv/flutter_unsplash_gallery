import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionErrorWidget extends StatelessWidget {
  ConnectionErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 180,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/connection_error.png",
              width: 100,
              height: 100,
            ),
          ),
          Flexible(
            child: Text(
              "Connection error",
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          Flexible(
            child: Text(
              "Check internet on your device",
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
