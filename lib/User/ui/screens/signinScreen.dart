import 'package:flutter/material.dart';
import '/widgets/gradient_back.dart';
import '/widgets/buttonsLogIn.dart';
import '/User/Bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_application_1/platzi_trips_cupertino.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

class SigninScreen extends StatefulWidget {
  @override
  State createState() {
    return _SigninScreen();
  }
}

class _SigninScreen extends State<SigninScreen> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _handlerCurrentSession();
  }

  Widget _handlerCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        } else {
          return PlatziTripsCupertino();
        }
      },
    );
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(' ', null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome \n This is your travel app!',
                style: TextStyle(
                    fontSize: 37.0,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              ButtonLogIn(
                text: 'Login with Google',
                onPressed: () {
                  userBloc.SignIn();
                },
                width: 300,
                height: 50,
              ),
              // SignInButton(
              //   Buttons.Google,
              //   text: "Sign up with Google",
              //   onPressed: () {},
              // ),
              // SignInButton(
              //   Buttons.Facebook,
              //   text: "Sign up with Facebook",
              //   onPressed: () {},
              // )
            ],
          )
        ],
      ),
    );
  }
}
