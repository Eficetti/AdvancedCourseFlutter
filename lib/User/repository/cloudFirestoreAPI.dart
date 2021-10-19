import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Place/model/place.dart';
import 'package:flutter_application_1/User/ui/widgets/profile_place.dart';
import '/User/model/user.dart';

class cloudFirestoreAPI {
  final String USERS = 'users';
  final String PLACES = 'places';

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> updateUserData(Usuario user) {
    CollectionReference users = _db.collection(USERS);
    DocumentReference ref = users.doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoURL,
      'myPlaces': user.myPlaces,
      'favoritesPlaces': user.favoritePlaces,
      'lastSignIn': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceDate(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    User user = _auth.currentUser;
    DocumentReference _userRef = _db.collection(this.USERS).doc(user.uid);
    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': _userRef,
      'urlImage': place.urlImage
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        snapshot.id;
        _userRef.update({
          'myPlaces':
              FieldValue.arrayUnion([_db.doc('${PLACES}/${snapshot.id}')])
        });
      });
    });
  }

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = [];
    placesListSnapshot.forEach((place) {
      profilePlaces.add(ProfilePlace(Place(
          name: place['name'],
          description: place['description'],
          urlImage: place['urlImage'],
          likes: place['likes'])));
    });
    return profilePlaces;
  }

  // ignore: missing_return
  List<Place> buildPlacesMainScreen(
      List<DocumentSnapshot> placesListSnapshot, Usuario user) {
    List<Place> places = [];

    placesListSnapshot.forEach((p) {
      Place place = Place(
          id: p.reference.id,
          name: p["name"],
          description: p["description"],
          urlImage: p["urlImage"],
          likes: p["likes"]);
      place.liked = false;
      places.add(place);
    });
    return places;
  }

  Future likePlace(Place place, String uid) async {
    await _db
        .collection(PLACES)
        .doc(place.id)
        .get()
        .then((DocumentSnapshot ds) {
      int likes = ds["likes"];

      _db.collection(PLACES).doc(place.id).update({
        'likes': place.liked ? likes + 1 : likes - 1,
        'usersLiked': place.liked
            ? FieldValue.arrayUnion([_db.doc("${USERS}/${uid}")])
            : FieldValue.arrayRemove([_db.doc("${USERS}/${uid}")])
      });
    });
  }
}
