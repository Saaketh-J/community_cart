import 'dart:async';
import 'package:community_cart/AppScreens/profilePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:community_cart/globals.dart' as globals;

import 'groupMain.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

//Get addresses into a list from firebase
//Convert addresses to LatLang
//Find nearby addresses and store in new list
//Show addresses in new list on map

var addresses = [];
List<List<Placemark>> latlangValues = List<List<Placemark>>();
Set<Marker> userMarkers = Set.from([]);

Future<List<List<Placemark>>> getUsersLocations(context) async {
  var usersRef = FirebaseDatabase.instance.reference().child("users");

  await usersRef.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, value) {
      addresses.add(value['address']);
    });
  });
  for (int i = 0; i < addresses.length; i++) {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(addresses[i]);
    latlangValues.add(placemark);
  }
  print("KHDGIH");
  print(latlangValues[1][0].position.latitude);
  print(latlangValues[1][0].position.longitude);
  var hi = getMarkers(context);
  return latlangValues;
}

Set<Marker> getMarkers(context) {
//  var currentUserAddress = "";
//  var usersRef = FirebaseDatabase.instance.reference().child("users");
//  usersRef.once().then((DataSnapshot snapshot) {
//    Map<dynamic, dynamic> values = snapshot.value;
//    values.forEach((key, value) {
//      if (globals.userName == value['email']) {
//        //print("hilo");
//        //print(value['id']);
//        currentUserAddress = value['address'];
//      }
//    });
//  });
//  print(currentUserAddress);
//  List<Placemark> currentAddressCoord = await Geolocator().placemarkFromAddress(currentUserAddress);
//  print(currentAddressCoord);

  //List<List<Placemark>> closeUsers = List<List<Placemark>>();
  print("ghiehg");
  print(latlangValues.length);
  for (int i = 0; i < latlangValues.length; i++) {
    print('eiji');
    Marker mk = Marker(
      markerId: MarkerId('$i'),
      position: LatLng(latlangValues[i][0].position.latitude,
          latlangValues[i][0].position.longitude),
    );
    userMarkers.add(mk);
  }
  print("DFHI");
  print(userMarkers);
  return userMarkers;
}

class mainBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getUsersLocations(context);
    return FutureBuilder<Widget>(
        future: waiting(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return MapView();
          } else {
            return Container(
              decoration: BoxDecoration(color: Color(0xff000080)),
              child: Center(
                  child: SpinKitPouringHourglass(
                color: Colors.white,
                size: 80.0,
              )),
            );
          }
        });
  }
}

Future<Widget> waiting() =>
    // Imagine that this function is
// more complex and slow.
    Future.delayed(
      Duration(seconds: 7),
      () => fake(),
    );

class fake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(width: 0.0, height: 0.0);
  }
}

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    //getUsersLocations(context);
    //getMarkers(context);
    print(userMarkers);
    return new Scaffold(
      bottomNavigationBar: Container(
        height: 65.0,
        child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.chat, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.group, color: Colors.white),
                onPressed: () {
                  nextPage(context, MainGroupPage());
                },
              ),
              IconButton(
                icon: Icon(Icons.account_box, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          markers: userMarkers,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Row(children: <Widget>[
              FloatingActionButton(
                onPressed: () => profilePage(context),
                child: Icon(Icons.map),
              ),
            ]))
      ]),
    );
  }
}

void profilePage(BuildContext context) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return ProfilePage();
      });
}

void nextPage(BuildContext context, page) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return page;
      });
}
