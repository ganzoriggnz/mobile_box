import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobilbox/style/theme.dart' as Style;

class WebViewContainer extends StatefulWidget {
  final String url;
  WebViewContainer({@required this.url});
  @override
  createState() => _WebViewContainerState();
}
class _WebViewContainerState extends State<WebViewContainer> {
  final _key = UniqueKey();
  _WebViewContainerState();
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
        title: Text('Цагдаагийн ерөнхий газар', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18)),
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
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.url))
          ],
        ));
  }
}