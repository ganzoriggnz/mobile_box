import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import '../../model/mobile_operators.dart';
import 'choose_unit.dart';

class MobileUnits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 56,
            padding: EdgeInsets.only(top: 48),
            child: Center(
              child: ListView.builder(
                  itemCount: operators.length,
                  itemBuilder: (BuildContext context, int idx) {
                    Operator operator = operators[idx];
                    return GestureDetector(
                      onTap: () {
                        Style.navigatorPush(
                            ChooseUnit(operator: operator), context);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 72, vertical: 12),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: Style.Colors.bannerGradient),
                        height: 90,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: SizedBox(
                                  height: 45,
                                  child: Image.asset(operator.imgPath)),
                            ),
                            Text(operator.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            SizedBox()
                          ],
                        )),
                      ),
                    );
                  }),
            )));
  }
}
