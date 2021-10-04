import 'package:flutter/material.dart';
import 'package:flutter_application_1/Place/ui/screens/addPlaceScreen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'circle_button.dart';
import '/User/Bloc/bloc_user.dart';
import 'dart:io';
import '/Place/ui/screens/addPlaceScreen.dart';

// ignore: must_be_immutable
class ButtonsBar extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            CircleButton(true, Icons.vpn_key, 20.0,
                Color.fromRGBO(255, 255, 255, 0.6), () => {}),
            CircleButton(
                false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1), () {
              File image;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => addPlaceScreen(
                            Image: image,
                          )));
            }),
            CircleButton(
                true,
                Icons.exit_to_app,
                20.0,
                // ignore: sdk_version_set_literal
                Color.fromRGBO(255, 255, 255, 0.6),
                // ignore: sdk_version_set_literal
                () => {userBloc.signOut()}),
          ],
        ));
  }
}
