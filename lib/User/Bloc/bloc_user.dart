import 'dart:async';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/User/repository/authRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/User/repository/cloudFirestoreRepository.dart';
import '/User/model/user.dart';
import '/Place/model/place.dart';

class UserBloc implements Bloc {
  final _authRepository = AuthRepository();

  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  Future<User> SignIn() {
    return _authRepository.signInFirebase();
  }

  final _cloudFirestoreRepository = CloudFirestoreRepository();

  Future<void> updateUserData(Usuario user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreRepository.updatePlaceDate(place);

  signOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {}
}
