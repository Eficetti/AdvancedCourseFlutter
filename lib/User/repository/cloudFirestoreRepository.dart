import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/User/ui/widgets/profile_place.dart';
import 'cloudFirestoreAPI.dart';
import '/User/model/user.dart';
import '/Place/model/place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = cloudFirestoreAPI();

  Future<void> updateUserDataFirestore(Usuario user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreAPI.updatePlaceDate(place);

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildPlaces(placesListSnapshot);

  List<Place> buildPlacesMainScreen(
          List<DocumentSnapshot> placesListSnapshot, Usuario user) =>
      _cloudFirestoreAPI.buildPlacesMainScreen(placesListSnapshot, user);

  Future likePlace(Place place, String uid) =>
      _cloudFirestoreAPI.likePlace(place, uid);
}
