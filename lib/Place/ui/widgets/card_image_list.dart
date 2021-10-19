import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Bloc/bloc_user.dart';
import 'card_image.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/Place/model/place.dart';
import '/User/model/user.dart';
// ignore: must_be_immutable

// ignore: must_be_immutable
class CardImageList extends StatefulWidget {
  Usuario user;
  CardImageList(this.user);
  @override
  State<StatefulWidget> createState() {
    return _CardImageList();
  }
}

class _CardImageList extends State<CardImageList> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    Usuario user;
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
        height: 350.0,
        child: StreamBuilder(
          stream: userBloc.placesStream,
          // ignore: missing_return
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                return listViewPlaces(userBloc.buildPlacesMainScreen(
                    snapshot.data.docs, widget.user));
              case ConnectionState.done:
                return listViewPlaces(userBloc.buildPlacesMainScreen(
                    snapshot.data.docs, widget.user));
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
            }
          },
        ));
  }

  Widget listViewPlaces(List<Place> places) {
    void setLiked(Place place) {
      setState(() {
        place.liked = !place.liked;
        userBloc.likePlace(place, widget.user.uid);
        place.likes = place.liked ? place.likes + 1 : place.likes - 1;
        userBloc.placeSelectedSink.add(place);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place) {
        return GestureDetector(
            onTap: () {
              print('CLICK PLACE: ${place.name}');
              userBloc.placeSelectedSink.add(place);
            },
            child: CardImage(
              pathImage: place.urlImage,
              iconData: place.liked ? iconDataLiked : iconDataLike,
              onPressedFabIcon: () {
                setLiked(place);
              },
            ));
      }).toList(),
    );
  }
}
