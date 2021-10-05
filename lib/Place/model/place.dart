import '/User/model/user.dart';
import 'package:flutter/material.dart';

class Place {
  String id;
  String name;
  String description;
  String urlImage;
  int likes;
  Usuario userOwner;

  Place(
      {Key key,
      this.id,
      this.name,
      this.description,
      this.urlImage,
      this.likes,
      this.userOwner});
}
