import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/User/repository/cloudFirestoreAPI.dart';
import 'package:flutter_application_1/User/ui/widgets/profile_place.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/User/repository/authRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/User/repository/cloudFirestoreRepository.dart';
import '/User/model/user.dart';
import '/Place/model/place.dart';
import '/Place/repository/FirebaseStorageRepository.dart';
import 'dart:io';

class UserBloc implements Bloc {
  final _authRepository = AuthRepository();

  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  Future<User> SignIn() {
    return _authRepository.signInFirebase();
  }

  Future<User> currentUser() async {
    User user = FirebaseAuth.instance.currentUser;
    return user;
  }

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  final _cloudFirestoreRepository = CloudFirestoreRepository();

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(cloudFirestoreAPI().PLACES)
      .snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  List<Place> buildPlacesMainScreen(
          List<DocumentSnapshot> placesListSnapshot, Usuario user) =>
      _cloudFirestoreRepository.buildPlacesMainScreen(placesListSnapshot, user);

  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore
      .instance
      .collection(cloudFirestoreAPI().PLACES)
      .where('userOwner',
          isEqualTo: FirebaseFirestore.instance
              .doc('${cloudFirestoreAPI().USERS}/${uid}'))
      .snapshots();
  Future<void> updateUserData(Usuario user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreRepository.updatePlaceDate(place);

  Future likePlace(Place place, String uid) =>
      _cloudFirestoreRepository.likePlace(place, uid);

  StreamController<Place> placeSelectedStreamController =
      StreamController<Place>();
  Stream<Place> get placeSelectedStream => placeSelectedStreamController.stream;
  StreamSink<Place> get placeSelectedSink => placeSelectedStreamController.sink;

  signOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {}
}
