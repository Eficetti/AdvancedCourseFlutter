import 'package:flutter/material.dart';
import 'package:flutter_application_1/Place/model/place.dart';
import 'package:flutter_application_1/Place/ui/widgets/card_image.dart';
import 'package:flutter_application_1/User/Bloc/bloc_user.dart';
import 'package:flutter_application_1/widgets/button_purple.dart';
import 'dart:io';
import 'package:flutter_application_1/widgets/gradient_back.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '/widgets/titleHeader.dart';
import '/widgets/textInput.dart';
import '/Place/ui/widgets/titleInputLocation.dart';

// ignore: must_be_immutable
class addPlaceScreen extends StatefulWidget {
  File Image;

  addPlaceScreen({Key key, this.Image});
  State createState() {
    return _addPlaceScreen();
  }
}

class _addPlaceScreen extends State<addPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();
    final _controllerlocationPlace = TextEditingController();
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          GradientBack(height: 300),
          Row(children: [
            Container(
                padding: EdgeInsets.only(top: 25, left: 5),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left,
                        color: Colors.white, size: 45),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
            Flexible(
                child: Container(
              width: screenWidth,
              child: Container(
                padding: EdgeInsets.only(top: 45, left: 20, right: 10),
                child: TittleHeader(
                  title: 'Add a new place',
                ),
              ),
            ))
          ]),
          Container(
            margin: EdgeInsets.only(top: 120, bottom: 20),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CardImage(
                    pathImage:
                        'assets/img/beach_palm.jpeg', //widget.Image.path,
                    iconData: Icons.camera_alt,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: TextInput(
                    controller: _controllerTitlePlace,
                    hintText: 'Title',
                    inputType: null,
                  ),
                ),
                TextInput(
                  hintText: 'Description',
                  inputType: TextInputType.multiline,
                  controller: _controllerDescriptionPlace,
                  maxlines: 4,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: titleInputLocation(
                    hintText: 'Add Location',
                    iconData: Icons.location_on,
                    controller: _controllerlocationPlace,
                  ),
                ),
                Container(
                  width: 70,
                  child: ButtonPurple(
                    buttonText: 'Add place',
                    onPressed: () {
                      userBloc
                          .updatePlaceDate(Place(
                              name: _controllerTitlePlace.text,
                              description: _controllerDescriptionPlace.text,
                              likes: 0))
                          .whenComplete(() {
                        print('termino');
                        Navigator.pop(context);
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
