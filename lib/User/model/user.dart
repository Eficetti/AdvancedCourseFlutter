import 'package:flutter/material.dart';

class Usuario {
  final String name;
  final String email;
  final String photoURL;

  // favoritePlace
  // myPlaces

  Usuario(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.photoURL});
}
