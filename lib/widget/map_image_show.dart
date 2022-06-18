import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/common_login_model.dart';

class MapImageShow extends StatefulWidget {
  double lat;
  double long;
  String image;
  String details;

  MapImageShow({this.lat, this.long,this.image,this.details});

  @override
  _MapImageShowState createState() => _MapImageShowState(lat: lat,long: long,image: image,details: details);
}

class _MapImageShowState extends State<MapImageShow> {
  double lat;
  double long;
  String image;
  String details;

  _MapImageShowState({this.lat, this.long, this.image,this.details});

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final coordinates = new Coordinates(lat,long);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.addressLine);
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("test"),
        position: LatLng(lat,long),
        infoWindow: InfoWindow(
          title: first.postalCode,
          snippet: first.addressLine,
        ),
      );
      _markers[first.featureName] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 1,top: 10),
        child: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.01),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Center(
              child: Icon(Icons.arrow_back,color: Colors.red,)
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body:Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
                child:lat!=null?GoogleMap(
                  onMapCreated: _onMapCreated,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(lat,long),
                      zoom: 20,
                      tilt: 15
                  ),
                  markers: _markers.values.toSet(),
                ):Center(child: Text('No map available'),) ),
            image!=null?Expanded(
              flex: 1,
                child:Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Container(
                    color: AppTheme.nearlyWhite,
                    child: Stack(
                      children: [
                        Center(
                          child: Hero(
                            tag: 'Details',
                            child: Image.network(
                              image,
                            ),
                          ),
                        ),
                        details!=null?Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(padding: EdgeInsets.only(bottom: 10),
                              child: Container(
                                color: AppTheme.nearlyWhite,
                                  child: Text("বিবরণ: "+details,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),)),)
                        ):Text('')
                      ],
                    ),
                  ), )):Text('')
          ],
        ),
      )
      /*Stack(
        children: [
        GoogleMap(
        onMapCreated: _onMapCreated,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat,long),
          zoom: 20,
          tilt: 15
        ),
        markers: _markers.values.toSet(),
      ),
          image!=null?Align(
            alignment: Alignment.,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: 'Details',
                        child: Image.network(
                          image,
                        ),
                      ),
                    ),
                    details!=null?Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(padding: EdgeInsets.only(bottom: 50),
                          child: Text("বিবরণ: "+details,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),)
                    ):Text('')
                  ],
                ),
              ),
            ),
          ):Text('')
    ],
      ),*/
    );
  }
}
