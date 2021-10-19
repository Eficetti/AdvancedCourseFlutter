import 'package:flutter_application_1/User/Bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import '/widgets/button_purple.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/Place/model/place.dart';

class DescriptionPlace extends StatelessWidget {
  final String namePlace;
  final int stars;
  final String descriptionPlace;

  DescriptionPlace(this.namePlace, this.stars, this.descriptionPlace);

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);

    // ignore: unused_local_variable
    final starBorder = Container(
      margin: EdgeInsets.only(top: 353.0, right: 3.0),
      child: Icon(
        Icons.star_border,
        color: Color(0xFFf2C611),
      ),
    );

    return StreamBuilder(
      stream: userBloc.placeSelectedStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Place place = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleStars(place),
              description(place.description),
              ButtonPurple(buttonText: "Navigate", onPressed: () {})
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
                child: Text(
                  "Selecciona un lugar",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget titleStars(Place place) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 350.0, left: 20.0, right: 20.0),
          child: Text(
            place.name,
            style: TextStyle(
                fontFamily: "Lato",
                fontSize: 30.0,
                fontWeight: FontWeight.w900),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 370.0,
          ),
          child: Text(
            "Hearts: ${place.likes}",
            style: TextStyle(
                fontFamily: "Lato",
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: Colors.amber),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget description(String decriptionPlace) {
    return Container(
      margin: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: new Text(
        descriptionPlace,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)),
      ),
    );
  }
}
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     titleStars,
    //     description,
    //     ButtonPurple(
    //       buttonText: "Navigate",
    //     )
    //   ],
    // );
