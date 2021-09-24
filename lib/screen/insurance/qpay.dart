import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/model/invoice.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:mobilbox/authentication/authentication.dart';
import 'choose_bank.dart';
import 'package:http/http.dart' as http;
import 'package:mobilbox/repositories/repositories.dart';
import 'dart:convert';

class QPay extends StatefulWidget {
  final int idx;
  QPay({@required this.idx});
  @override
  QPayState createState() => QPayState();
}

class QPayState extends State<QPay> {
  Invoice invoice;
  @override
  void initState() {
    super.initState();
    getChoiceId();
  }

  getChoiceId() async {
    var url = homeUrl + 'payment/${widget.idx + 1}';
    var token = await UserRepository().getToken();
    var res =
        await http.get(Uri.parse(url), headers: {"Authorization": "$token"});
    var resJson = json.decode(res.body);
    Invoice _invoice = Invoice.fromJson(resJson['data']);
    setState(() {
      invoice = _invoice;
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
        height: screen.height - safe.top - safe.bottom - 56,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              invoice != null
                  ? Container(
                      width: 250,
                      height: 250,
                      color: Colors.white,
                      child: Image.memory(base64Decode(invoice.qrImage)))
                  : Container(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Style.Colors.gradientBegin),
                      )),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: GestureDetector(
                  onTap: () {
                    invoice != null
                        ? Style.navigatorPush(
                            BankChoices(
                              deeplinks: invoice.deeplinks,
                            ),
                            context)
                        : print('waiting');
                  },
                  child: Container(
                      width: 110,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          gradient: Style.Colors.buttonGradient),
                      child: Center(
                        child: Text(
                            invoice != null ? 'Банк сонгох' : 'Түр хүлээнэ үү',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
