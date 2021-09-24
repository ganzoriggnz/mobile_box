import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:flutter/services.dart';

class TransactionInfo extends StatelessWidget {
  final int price;
  TransactionInfo({@required this.price});

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var normalText =
        TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
    var valueText = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17);
    var psText = TextStyle(
        color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12);
    const kDefaultPadding = 12.0;

    _copyToClip(String value) {
      Clipboard.setData(ClipboardData(text: value));
      final snackBar = SnackBar(content: Text('Түр санах ойд хууллаа.'));
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
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: Style.Colors.buttonGradient),
          padding: EdgeInsets.only(top: 24, left: 24, right: 20, bottom: 0),
          margin: EdgeInsets.symmetric(vertical: 36, horizontal: 36),
          width: double.infinity,
          height: 480,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Дансаар шилжүүлэх заавар',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                Divider(color: Colors.white, thickness: 1),
                SizedBox(height: 24),
                Text('Хүлээн авагч банк:', style: normalText),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    children: [
                      Spacer(),
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/bankicons/Khas.png')),
                      SizedBox(width: 10),
                      Text('Хас банк', style: valueText),
                    ],
                  ),
                ),
                Text('Данс эзэмшигчийн нэр:', style: normalText),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text('Мобайлзоне ХХК', style: valueText),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.copy, color: Colors.white),
                        onPressed: () {
                          _copyToClip('Мобайл зоне ХХК');
                        },
                      )
                    ],
                  ),
                ),
                Text('Дансны дугаар:', style: normalText),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text('5002637368', style: valueText),
                      IconButton(
                        iconSize: 20,
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                        icon: Icon(Icons.copy_rounded, color: Colors.white),
                        onPressed: () {
                          _copyToClip('5002637368');
                        },
                      )
                    ],
                  ),
                ),
                Text('Гүйлгээний утга:', style: normalText),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    children: [
                      Spacer(),
                      Text('Таны утасны дугаар', style: normalText)
                    ],
                  ),
                ),
                Text('Гүйлгээний дүн:', style: normalText),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(price.toString() + '₮', style: valueText),
                      IconButton(
                        iconSize: 20,
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                        icon: Icon(Icons.copy_rounded, color: Colors.white),
                        onPressed: () {
                          _copyToClip('$price');
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Divider(color: Colors.white, thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding - 2),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                          'Жич: таны гүйлгээ ажлын цагаар 2-3 \n цагийн хооронд баталгаажна.',
                          style: psText,
                          textAlign: TextAlign.right)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
