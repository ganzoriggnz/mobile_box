import 'dart:typed_data';
// import 'dart:ui' as ui;
import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:mobilbox/model/product.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail({Key key, @required this.product}) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState(product);
}

class _ProductDetailState extends State<ProductDetail> {
  bool isLeasingVisible = false;
  final Product product;
  // GlobalKey _renderObjectKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String image;

  final formatter = new NumberFormat("#,###");
  _ProductDetailState(this.product);
  @override
  void initState() {
    super.initState();
    image = product.imgLink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomAppBar(
        color: Style.Colors.mainColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 45.0,
                child: Row(
                  children: <Widget>[
                    Icon(
                      EvaIcons.shoppingCartOutline,
                      color: Colors.white,
                      size: 14.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Шууд авах",
                        style: new TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
            Container(
              height: 30.0,
              width: 0.3,
              color: Colors.white,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLeasingVisible = !isLeasingVisible;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 45.0,
                child: Row(
                  children: <Widget>[
                    Icon(
                      EvaIcons.activity,
                      color: Colors.white,
                      size: 12.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Зээлийн мэдээлэл",
                        style: new TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: new Text(
            product.name,
            style: TextStyle(
                fontSize: Theme.of(context).platform == TargetPlatform.iOS
                    ? 20.0
                    : 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: product.id,
            child: Container(
              height: MediaQuery.of(context).size.width,
              child: Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image))),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: Container(
          //     height: 50.0,
          //     child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: productImg.length,
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: const EdgeInsets.only(right: 10.0),
          //           child: GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 image = productImg[index]["url"];
          //               });
          //             },
          //             child: Container(
          //               height: 50,
          //               width: 50,
          //               decoration: BoxDecoration(
          //                   borderRadius:
          //                       BorderRadius.all(Radius.circular(5.0)),
          //                   image: DecorationImage(
          //                       fit: BoxFit.cover,
          //                       image: NetworkImage(productImg[index]["url"]))),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[],
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                product.price == null
                    ? Column(
                        children: <Widget>[
                          Text(
                            product.price.toString() + "₮",
                            style:
                                TextStyle(color: Colors.green, fontSize: 15.0),
                          )
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Text(
                            product.price.toString() + "₮",
                            style:
                                TextStyle(color: Colors.green, fontSize: 15.0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Stack(
                            children: <Widget>[
                              Text(
                                product.price.toString() + "₮",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 15.0),
                              ),
                              Positioned(
                                top: 8,
                                child: Transform.rotate(
                                  angle: -math.pi / 18,
                                  child: Container(
                                    height: 1,
                                    width: product.price
                                            .toString()
                                            .length
                                            .toDouble() *
                                        8,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Html(data: product.description),
          ),
          isLeasingVisible ? _leasingInfo(product.price) : SizedBox()
        ],
      ),
    );
  }

  Widget _leasingInfo(int price) {
    var textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    return Table(
      border: TableBorder.all(
          color: Colors.black26, width: 1, style: BorderStyle.solid),
      children: [
        TableRow(children: [
          TableCell(
            child: Center(child: Text('Үндсэн үнэ:', style: textStyle)),
            verticalAlignment: TableCellVerticalAlignment.bottom,
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Center(child: Text(price.toString())),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Center(child: Text('Зээлийн хугацаа', style: textStyle))),
          TableCell(
            child: Center(child: Text('12 cap')),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Center(child: Text('Зээлийн хүү', style: textStyle))),
          TableCell(
            child: Center(child: Text('8%')),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child:
                  Center(child: Text('Урьдчилгаа төлбөр', style: textStyle))),
          TableCell(child: Center(child: Text((price / 4).toString()))),
        ]),
        TableRow(children: [
          TableCell(
              child: Center(child: Text('Сард төлөх дүн', style: textStyle))),
          TableCell(
            child: Center(child: Text((price / 10).toString())),
          ),
        ]),
      ],
    );
  }

  // Future<Uint8List> _getWidgetImage() async {
  //   try {
  //     RenderRepaintBoundary boundary =
  //         _renderObjectKey.currentContext.findRenderObject();
  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData byteData =
  //         await image.toByteData(format: ui.ImageByteFormat.png);
  //     var pngBytes = byteData.buffer.asUint8List();
  //     var bs64 = base64Encode(pngBytes);
  //     debugPrint(bs64.length.toString());

  //     return byteData.buffer.asUint8List();
  //   } catch (exception) {
  //     throw exception;
  //   }
  // }

  showTermsDialog(BuildContext context, Uint8List data) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 70,
        child: Column(
          children: <Widget>[Image.memory(data)],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
