import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobilbox/model/menu.dart';
import 'package:mobilbox/screen/LoanRequirement.dart';
import 'package:mobilbox/screen/mobile_units/choose_operator.dart';
import 'package:mobilbox/screen/insurance/checkInsurance.dart';
import 'package:mobilbox/screen/police.dart';
import 'package:mobilbox/style/theme.dart' as Style;

class HomeHeader extends StatelessWidget {
  final menuItems = <Menu>[
    Menu(
        title: "Гар утас даатгал",
        img: 'assets/icons/insurance.svg',
        route: CheckInsurance()),
    Menu(
        title: "Нэгж цэнэглэх",
        img: 'assets/icons/money.svg',
        route: MobileUnits()),
    Menu(
        title: "Гар утас лизинг",
        img: 'assets/icons/transfer.svg',
        route: LoanRequirementPage()),
    Menu(
        title: "ЦЕГ",
        img: 'assets/images/police.png',
        route: Police())
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        children: menuItems.map<Widget>((Menu menu) {
          return GestureDetector(
              onTap: () {
                Style.navigatorPush(menu.route, context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Container(
                  height: 120,
                  width: 90,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[200], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: menu.title == 'ЦЕГ' ?
                        Image(image: AssetImage(menu.img))
                        : SvgPicture.asset(
                          menu.img,
                          colorBlendMode: BlendMode.darken,
                          placeholderBuilder: (BuildContext context) =>
                              new Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          menu.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Style.Colors.mainColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.0),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        }).toList());
  }
}
