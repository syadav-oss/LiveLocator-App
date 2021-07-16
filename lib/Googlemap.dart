import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Googlemap extends StatefulWidget {
  const Googlemap({ Key? key }) : super(key: key);

  @override
  _GooglemapState createState() => _GooglemapState();
}

class _GooglemapState extends State<Googlemap> {

  //List<Marker> allMarkers = [];

  bool mapToggle = false;


  // to store location coordinates
  var locationCoordiates;

  late GoogleMapController mapController;

  // fn to get user location
  void initState() {
   super.initState();
   Geolocator.getCurrentPosition().then((currloc) {
     setState(() {
       locationCoordiates = currloc;
       mapToggle = true;
     });
   });
  }

  


 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Google Map')),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height - 80.0,
                width: double.infinity,
                child: mapToggle ?
                GoogleMap( 
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(target: LatLng(locationCoordiates!.latitude, locationCoordiates!.longitude),
                  zoom: 10.0,
                  ),
                  markers: _createmarker(),
                  )
                  : Center(
                      child: Text(
                        'Loading... Please Wait',
                      style: TextStyle(fontSize: 26.0),
                      ),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }

  Set<Marker> _createmarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('my id'),
        position: LatLng(locationCoordiates!.latitude,locationCoordiates!.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Map"),
        ),
    ].toSet();
  }

}
