import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'qpay.dart';
import './transaction_info.dart';

class Insurance extends StatefulWidget {
  @override
  InsuranceState createState() => InsuranceState();
}

class InsuranceState extends State<Insurance> {
  int selectedIdx = 0;

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
      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    selectedIdx = 0;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 72, vertical: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: selectedIdx == 0
                          ? Border.all(
                              color: Style.Colors.gradientBegin, width: 3)
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: Style.Colors.bannerGradient),
                  height: 90,
                  child: Center(
                      child: Text('СОНГОЛТ 1 \n 1 жилийн эрх \n 10000₮',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white))),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    selectedIdx = 1;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 72, vertical: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: selectedIdx == 1
                          ? Border.all(
                              color: Style.Colors.gradientBegin, width: 3)
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: Style.Colors.bannerGradient),
                  height: 90,
                  child: Center(
                      child: Text('СОНГОЛТ 2 \n Хязгааргүй эрх \n 25000₮',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Style.navigatorPush(QPay(idx: selectedIdx), context);
                      },
                      child: Container(
                          width: 110,
                          height: 36,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              gradient: Style.Colors.buttonGradient),
                          child: Center(
                            child: Text('QPay',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          )),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Style.navigatorPush(
                            TransactionInfo(
                                price: selectedIdx == 0 ? 10000 : 25000),
                            context);
                        // determinePosition();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                          width: 110,
                          height: 36,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              gradient: Style.Colors.buttonGradient),
                          child: Center(
                            child: Text('Дансаар төлөх',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
