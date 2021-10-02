import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/User/ui/widgets/user_info.dart';
import '/User/ui/widgets/button_bar.dart';
import '/User/Bloc/bloc_user.dart';
import '/User/model/user.dart';

// ignore: must_be_immutable
class ProfileHeader extends StatelessWidget {
  UserBloc userBloc;

  Usuario user;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return StreamBuilder(
      stream: userBloc.streamFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return ShowProfileData(snapshot);
          case ConnectionState.done:
            return ShowProfileData(snapshot);
            break;
        }
      },
    );
  }

  Widget ShowProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print('no logeado');
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
      print('logeado');
      print(snapshot);
      user = Usuario(
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
