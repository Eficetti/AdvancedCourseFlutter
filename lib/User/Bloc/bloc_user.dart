import 'dart:async';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/User/repository/authRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBloc implements Bloc {
  final _authRepository = AuthRepository();

  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  Future<User> SignIn() {
    return _authRepository.signInFirebase();
  }

  signOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {}
}
