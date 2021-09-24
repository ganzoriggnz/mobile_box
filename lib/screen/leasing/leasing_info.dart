import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/style/theme.dart' as Style;

class LeasingInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(EvaIcons.chevronLeft, color: Style.Colors.mainColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: SizedBox(
              height: 50.0, child: Image.asset("assets/images/boxlogo.jpg")),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
                icon: Icon(
                  EvaIcons.logOutOutline,
                  color: Style.Colors.mainColor,
                ))
          ],
        ),
    );
  }
}