import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'profile_header.dart';
import '/User/ui/widgets/profile_places_list.dart';
import '/User/ui/widgets/profile_background.dart';
import '/User/model/user.dart';

// ignore: must_be_immutable
class ProfileTrips extends StatelessWidget {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return StreamBuilder(
      stream: userBloc.authStatus,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);
          case ConnectionState.none:
            return CircularProgressIndicator();
          default:
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print('no logeado');
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[Text('Usuario no logeado, haz loggin')],
          ),
        ],
      );
    } else {
      print('User logged');
      var user = Usuario(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[ProfileHeader(user), ProfilePlacesList(user)],
          ),
        ],
      );
    }
  }
}
