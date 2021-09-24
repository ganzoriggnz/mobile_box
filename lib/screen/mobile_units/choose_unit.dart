import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/model/mobile_operators.dart';
import 'package:mobilbox/style/theme.dart' as Style;

class ChooseUnit extends StatefulWidget {
  final Operator operator;
  // final List<Unit> units;
  ChooseUnit({@required this.operator});
  @override
  ChooseUnitState createState() => ChooseUnitState();
}

class ChooseUnitState extends State<ChooseUnit>
    with SingleTickerProviderStateMixin {
  String phoneNumber = '';
  int tabIndex = 0;
  TabController _tabController;
  List<Unit> units = [Unit(price: '', reward: '', type: '')];
  List<Unit> datas = [Unit(price: '', reward: '', type: '')];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _prepareUnits(widget.operator.units);
  }

  _prepareUnits(List<Unit> list) {
    List<Unit> _units = [];
    List<Unit> _datas = [];
    list.forEach((e) {
      if (e.type == 'unit') {
        _units.add(e);
      } else {
        _datas.add(e);
      }
    });
    setState(() {
      units = _units;
      datas = _datas;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var safe = MediaQuery.of(context).padding;
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
              height: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.operator.imgPath),
                  SizedBox(width: 8),
                  Text(
                    widget.operator.name,
                    style: TextStyle(
                        color: Style.Colors.mainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0),
                  )
                ],
              )),
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
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: Style.Colors.bannerGradient),
          width: screen.width,
          height: screen.height - safe.top - safe.bottom - 56,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '+976',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 102,
                    height: 40,
                    child: Theme(
                      data: ThemeData(primaryColor: Color(0x40FFFFFF)),
                      child: TextField(
                          onChanged: (text) {
                            phoneNumber = text;
                          },
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              hintText: "_ _ _ _ _ _ _ _",
                              contentPadding: EdgeInsets.only(left: 10.0),
                              counterText: "",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Style.Colors.mainColor)))),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),
              TabBar(
                unselectedLabelColor: Style.Colors.gradientEnd,
                isScrollable: false,
                labelColor: Colors.white,
                onTap: (int value) {
                  setState(() {
                    tabIndex = value;
                  });
                },
                tabs: [
                  Tab(
                    child: Container(
                        width: 140,
                        height: 40,
                        decoration: tabIndex == 0
                            ? BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                gradient: Style.Colors.buttonGradient)
                            : BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                color: Colors.transparent),
                        child: Center(child: Text("Дата"))),
                  ),
                  Tab(
                      child: Container(
                          width: 140,
                          height: 40,
                          decoration: tabIndex == 1
                              ? BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  gradient: Style.Colors.buttonGradient)
                              : BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: Colors.transparent),
                          child: Center(child: Text("Нэгж"))))
                ],
                controller: _tabController,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Divider(color: Colors.white, thickness: 3),
              SizedBox(height: 24),
              Expanded(
                  child: Container(
                width: double.infinity,
                child: _units(tabIndex == 0 ? datas : units),
              ))
            ],
          ),
        ));
  }

  Widget _units(List<Unit> list) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 1.2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: list.length,
      itemBuilder: (context, index) {
        Unit unit = list[index];
        return Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color(0x40FFFFFF)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(unit.price,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Divider(color: Colors.white, thickness: 1),
              Text(unit.reward,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        );
      },
    );
  }
}
