import 'package:flutter/material.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mobilbox/widgets/webview.dart';
import '../model/policeInfo.dart';

class Police extends StatefulWidget {
  @override
  PoliceState createState() => PoliceState();
}

class PoliceState extends State<Police> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(EvaIcons.chevronLeft, color: Style.Colors.mainColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Цагдаагийн ерөнхий газар',
            style: TextStyle(color: Color(0xff2f3192)),
          ),
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
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: Icon(EvaIcons.infoOutline, color: Colors.black),
                  child: Text('Мэдээ мэдээлэл',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center)),
              Tab(
                  icon: Icon(EvaIcons.gridOutline, color: Colors.black),
                  child: Text('Хууль эрх зүй',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center)),
              Tab(
                  icon: Icon(EvaIcons.hardDriveOutline, color: Colors.black),
                  child: Text('Бусад',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center)),
            ],
          ),
        ),
        body: TabBarView(
          children: [newsTab, lawsTab, othersTab],
        ),
      ),
    );
  }
}

Widget newsTab = Column(children: [
  Expanded(
    child: ListView.builder(
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Style.navigatorPush(
                  WebViewContainer(url: news[index].url), context);
            },
            behavior: HitTestBehavior.opaque,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(flex: index, child: Text(news[index].title)),
                      Row(
                        children: [
                          Spacer(),
                          Icon(EvaIcons.chevronRight, color: Colors.black87),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
  )
]);
Widget lawsTab = Column(children: [
  Expanded(
    child: ListView.builder(
        itemCount: lawNews.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Style.navigatorPush(
                  WebViewContainer(url: lawNews[index].url), context);
            },
            behavior: HitTestBehavior.opaque,
            child: Card(
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(flex: index, child: Text(lawNews[index].title)),
                    Icon(EvaIcons.chevronRight, color: Colors.black87)
                  ],
                ),
              ),
            ),
          );
        }),
  )
]);
Widget othersTab = Column(children: [
  Expanded(
    child: ListView.builder(
        itemCount: others.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Style.navigatorPush(
                  WebViewContainer(url: others[index].url), context);
            },
            behavior: HitTestBehavior.opaque,
            child: Card(
              margin: EdgeInsets.all(12),
              child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(flex: index, child: Text(others[index].title)),
                      Icon(EvaIcons.chevronRight, color: Colors.black87)
                    ],
                  )),
            ),
          );
        }),
  )
]);
