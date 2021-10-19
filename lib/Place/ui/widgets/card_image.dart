import 'package:flutter/material.dart';
import '/widgets/floating_action_button_green.dart';

// ignore: must_be_immutable
class CardImage extends StatelessWidget {
  final double heigth;
  final double width;
  double marginLeft = 20;
  final String pathImage;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;

  CardImage(
      {Key key,
      @required this.pathImage,
      this.heigth = 350,
      this.width = 350,
      this.onPressedFabIcon,
      @required this.iconData});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: heigth,
      width: width,
      margin: EdgeInsets.only(top: 80.0, left: marginLeft),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(pathImage)),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0))
          ]),
    );

    return Stack(
      alignment: Alignment(0.9, 1.1),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(
            iconData: iconData, onPressed: onPressedFabIcon)
      ],
    );
  }
}
