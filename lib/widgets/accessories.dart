import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/bloc/product_gear_list_bloc.dart';
import 'package:mobilbox/model/product.dart';
import 'package:mobilbox/model/product_response.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import '../screen/products.dart';
import 'product_detail.dart';

class Accessories extends StatefulWidget {
  @override
  _AccessoriesState createState() => _AccessoriesState();
}

class _AccessoriesState extends State<Accessories> {
  @override
  void initState() {
    super.initState();
    productsGearBloc..getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        "assets/icons/usb.svg",
                        colorBlendMode: BlendMode.darken,
                        placeholderBuilder: (BuildContext context) =>
                            new Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Бараанууд".toUpperCase(),
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Style.navigatorPush(Products(), context);
                  },
                  child: Text(
                    "Бүгд".toUpperCase(),
                    style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0),
                  ),
                )
              ],
            )),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<ProductResponse>(
          stream: productsGearBloc.subject.stream,
          builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildAccessoriesWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildAccessoriesWidget(ProductResponse data) {
    List<Product> products = data.products;
    return Container(
      height: 215.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var productImg = products[index].imgLink;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            product: products[index],
                          )));
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: products[index].id,
                      child: Container(
                          margin: EdgeInsets.all(6),
                          width: 105.0,
                          height: 105.0,
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(productImg)),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        products[index].name,
                        style: TextStyle(
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        products[index].price.toString() + "₮",
                        style: TextStyle(
                            color: Style.Colors.titleColor, fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
