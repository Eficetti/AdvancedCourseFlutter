import 'package:flutter/material.dart';
import '/User/ui/widgets/user_info.dart';
import '/User/ui/widgets/button_bar.dart';
import '/User/model/user.dart';

// ignore: must_be_immutable
class ProfileHeader extends StatelessWidget {
  Usuario user;
  ProfileHeader(this.user);
  @override
  Widget build(BuildContext context) {
    final title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0),
    );
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[title],
          ),
          UserData(user),
          ButtonsBar()
        ],
      ),
    );
  }

  Widget ShowProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text('No es posible cargar la informacion!')
          ],
        ),
      );
    } else {
      user = Usuario(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);
      final title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );
      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[title],
            ),
            UserData(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
