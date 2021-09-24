import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/model/product.dart';
import 'package:mobilbox/model/product_response.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:mobilbox/widgets/product_detail.dart';
import '../bloc/products_list_block.dart';

class Products extends StatefulWidget {
  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    productsGearBloc..getProducts();
  }

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
        // child: Image.asset(banks[index].imgPath),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 56,
        child: StreamBuilder<ProductResponse>(
          stream: productsGearBloc.subject.stream,
          builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildAccessoriesWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ),
    );
  }
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
          valueColor: new AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
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
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
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
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
