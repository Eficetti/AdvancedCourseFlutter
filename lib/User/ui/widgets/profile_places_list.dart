import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/User/Bloc/bloc_user.dart';
import '/User/model/user.dart';

// ignore: must_be_immutable
class ProfilePlacesList extends StatelessWidget {
  UserBloc userBloc;
  Usuario user;
  ProfilePlacesList(this.user);
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: StreamBuilder(
        stream: userBloc.myPlacesListStream(user.uid),
        // ignore: missing_return
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return Column(
                children: [
                  // ignore: sdk_version_ui_as_code
                  ...userBloc.buildPlaces(snapshot.data.docs),
                ],
              );
            case ConnectionState.done:
              return Column(
                children: [
                  // ignore: sdk_version_ui_as_code
                  ...userBloc.buildPlaces(snapshot.data.docs)
                ],
              );
            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return Column(
                children: <Widget>[
                  // ignore: sdk_version_ui_as_code
                  ...userBloc.buildPlaces(snapshot.data.docs),
                ],
              );
          }
        },
      ),
    );
  }
}
