import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/Place/repository/FirebaseStorageAPI.dart';
import 'FirebaseStorageAPI.dart';
import 'dart:io';
import 'dart:async';

class FirebaseStorageRepository {
  final _firebaseStorageAPI = FirebaseStorageAPI();
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageAPI.uploadFile(path, image);
}
