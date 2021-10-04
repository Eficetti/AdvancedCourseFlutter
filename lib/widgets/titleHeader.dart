import 'package:flutter/material.dart';

class TittleHeader extends StatelessWidget {
  final String title;

  TittleHeader({Key key, @required this.title});
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold));
  }
}
