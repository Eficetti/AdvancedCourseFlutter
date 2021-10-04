import 'dart:async';
import 'cloudFirestoreAPI.dart';
import '/User/model/user.dart';
import '/Place/model/place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = cloudFirestoreAPI();

  Future<void> updateUserDataFirestore(Usuario user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreAPI.updatePlaceDate(place);
}
