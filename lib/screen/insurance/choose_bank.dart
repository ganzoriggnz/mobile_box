import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/model/invoice.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:url_launcher/url_launcher.dart';

class BankChoices extends StatelessWidget {
  final List<Deeplink> deeplinks;
  BankChoices({@required this.deeplinks});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var safe = MediaQuery.of(context).padding;

    _openBankApp(String link) async {
      final snackBar = SnackBar(content: Text('Аппликейшн суулгаагүй байна.'));
      if (await canLaunch(link))
        await launch(link);
      else
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      key: _scaffoldKey,
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
          ]),
      body: Container(
          padding: EdgeInsets.all(24),
          width: double.infinity,
          height: screen.height - safe.top - safe.bottom - 56,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: deeplinks.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _openBankApp(deeplinks[index].link);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(deeplinks[index].logo)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[300]))),
              );
            },
          )),
    );
  }
}
