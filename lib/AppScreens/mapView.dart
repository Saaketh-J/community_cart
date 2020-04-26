import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
var usersRef = FirebaseDatabase.instance.reference().child("users");
List<List<Placemark>> latlangValues;

Future<List<List<Placemark>>> getUsersLocations(context) async {
  await usersRef.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, value) {
      addresses.add(value['address']);
    });
  });
  print(addresses);
  for(int i = 0; i < addresses.length; i++){
    List<Placemark> placemark = await Geolocator().placemarkFromAddress(addresses[i]);
    latlangValues.add(placemark);
  }
  print(latlangValues);
  return latlangValues;
}

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    getUsersLocations(context);
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
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
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
