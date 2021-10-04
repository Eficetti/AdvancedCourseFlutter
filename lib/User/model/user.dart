import 'package:flutter/material.dart';
import '/Place/model/place.dart';

class Usuario {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Place> myPlaces;
  final List<Place> favoritePlaces;

  Usuario(
      {Key key,
      @required this.uid,
      @required this.name,
      @required this.email,
      @required this.photoURL,
      this.myPlaces,
      this.favoritePlaces});
}
