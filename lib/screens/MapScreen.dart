

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({ Key? key, this.initalPosition}) : super(key: key);
  final LatLng? initalPosition;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

Completer<GoogleMapController> _controller = Completer();

  CameraPosition? _kGooglePlex;

  @override
  void initState() { 
    super.initState();
    _kGooglePlex = CameraPosition(
      target: widget.initalPosition!,
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Map View", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white10,
      ),
      body: _kGooglePlex != null ? Container(
        child: GoogleMap(
          mapType: MapType.hybrid,
          markers: {
            Marker(
              markerId: MarkerId("user_marker"),
              position: widget.initalPosition!,
            ),
          },
          initialCameraPosition: _kGooglePlex!,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }

}