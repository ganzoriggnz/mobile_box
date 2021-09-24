import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mobilbox/repositories/repositories.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mobilbox/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'dart:convert';
import './insurance.dart';
// import 'package:background_location/background_location.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";

class CheckInsurance extends StatefulWidget {
  @override
  CheckInsuranceState createState() => CheckInsuranceState();
}

class CheckInsuranceState extends State<CheckInsurance> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  Timer timer;
  String locationdata = "";
  bool isload = false;

  Location location = Location();

  double lat = 0.0;
  double long = 0.0;
  @override
  void initState() {
    super.initState();
    checkInsurance();
  }

@override
  void dispose() {
    super.dispose();
  }

  checkInsurance() async {
    var url = homeUrl + 'checkDaatgal';
    String token = await UserRepository().getToken();
    var res = await http.get(Uri.parse(url), headers: {'Authorization': token});
    var resJson = json.decode(res.body);
    await Future.delayed(Duration.zero);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Attention!',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            content: Text(
                'This app collects location data to enable insurance for your phone even when the app is closed or not in use. Your data will be secured by NPA. We do not sell or share your personal information. \n\nУтсаа даатгуулахын тулд байршлын мэдээлэл авах зөвшөөрөл олгоно уу.'),
            actions: [
              TextButton(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     side: BorderSide(color: Colors.blue)),
                  onPressed: () async {
                    if (resJson['daatgal'] == false) {
                      Style.pushReplacement(Insurance(), context);
                    } else {                    
                      getLoc();
                      Navigator.of(context).pop();                     
                      // await BackgroundLocation.setAndroidConfiguration(10000);
                      // BackgroundLocation.startLocationService(distanceFilter: 10);
                      // BackgroundLocation.getLocationUpdates((location) {
                      //   setState(() {
                      //     lat = location.latitude;
                      //     long = location.longitude;
                      //   });
                      //   sendLocation(location.longitude, location.latitude);
                      // });
                      
                    }
                  },
                  child: Text('OK',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500)))
            ],
          );
        });
  }

  void sendLocation(double x, double y) async {
    var _url = homeUrl + 'addLocation';
    String token = await UserRepository().getToken();

    var data = {'location_x': x.toString(), 'location_y': y.toString()};
    var body = json.encode(data);
    print(data);
    var _res =
        await http.post(Uri.parse(_url),
        headers: {'Authorization': token}, body: body);
    print(_res.body);
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var safe = MediaQuery.of(context).padding;
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
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                  icon: Icon(
                    EvaIcons.logOutOutline,
                    color: Style.Colors.mainColor,
                  ))
            ]),
        body: Container(
            width: double.infinity,
            height: screen.height - safe.top - safe.bottom - 56,
            child: lat != null && long != null
                ? FlutterMap(
                    options: MapOptions(
                      center: LatLng(lat, long),
                      zoom: 13.0,
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(lat, long),
                            builder: (ctx) => Container(
                              child: Icon(Icons.location_on, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Style.Colors.gradientBegin)),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Даатгалын төлвийг шалгаж байна....',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 12),
                    ],
                  )));
  }


  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // background deer location awah hereg zuwshuurul
    location.enableBackgroundMode(enable: true);

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // location awah permission ee asuuh heseg
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    timer = Timer.periodic(const Duration(milliseconds: 10000), (Timer t) {
      // bairshilaa state utgand ugch bgaa heseg
      location.onLocationChanged.listen((LocationData currentLocation) {
        setState(() {
          lat = currentLocation.latitude;
          long = currentLocation.longitude;
        });
        sendLocation(lat, long);
        print("${currentLocation.longitude} : ${currentLocation.latitude}");
      });
    });
  }
}
