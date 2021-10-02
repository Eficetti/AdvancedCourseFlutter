import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'firebaseAuthAPI.dart';

class AuthRepository {
  // ignore: non_constant_identifier_names
  final _FirebaseAuthAPI = FirebaseAuthAPI();

  Future<auth.User> signInFirebase() => _FirebaseAuthAPI.signIn();

  signOut() => _FirebaseAuthAPI.signOut();
}
