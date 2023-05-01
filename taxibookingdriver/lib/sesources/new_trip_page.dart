import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxibookingdriver/global/global.dart';
import 'package:taxibookingdriver/methods/assistant_methods.dart';
import 'package:taxibookingdriver/models/user_ride_request_information.dart';
import 'package:taxibookingdriver/widgets/progress_dialog.dart';

class NewTripPage extends StatefulWidget {
  UserRideRequestInformation? userRideRequestDetail;

  NewTripPage({this.userRideRequestDetail});

  @override
  State<NewTripPage> createState() => _NewTripPageState();
}

class _NewTripPageState extends State<NewTripPage> {

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newTripGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.032951, 108.220983),
    zoom: 16,
  );

  Set<Marker> setOfMarkers = Set<Marker>();
  Set<Circle> setOfCircles = Set<Circle>();
  Set<Polyline> setOfPolylines = Set<Polyline>();
  List<LatLng> polylinePositionCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  double mapPadding = 0;
  BitmapDescriptor? iconAnimatedMarker;
  var geoLocator = Geolocator();
  Position? onlineDriverCurrentPosition;

  String rideRequestStatus = "accepted";

  String durationFromOriginToDestination = "";

  bool isRequestDirectionDetails = false;

  // Future<void> drawPolylineFromOriginToDestination(LatLng originLatLng, LatLng destinationLatLng, bool darkTheme) async {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => ProgressDialog(message: "Vui Lòng Đợi...",),
  //   );
  //
  //   //var directionDetailsInfo = await AssistantMethods
  //
  //   Navigator.pop(context);
  //
  //   PolylinePoints pPoints = PolylinePoints();
  //   List<PointLatLng> decodedPolylinePointsResultList = pPoints.decodePolyline(directionDetailsInfo.e_points!);
  //
  //   polylinePositionCoordinates.clear();
  //
  //   if(decodedPolylinePointsResultList.isNotEmpty){
  //     decodedPolylinePointsResultList.forEach((PointLatLng pointLatLng) {
  //       polylinePositionCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
  //     });
  //   }
  //
  //   setOfPolylines.clear();
  //
  //   setState(() {
  //     Polyline polyline = Polyline(
  //       color: darkTheme ? Colors.amber.shade400 : Colors.blue,
  //       polylineId: PolylineId("PolylineID"),
  //       jointType: JointType.round,
  //       points: polylinePositionCoordinates,
  //       startCap: Cap.roundCap,
  //       endCap: Cap.roundCap,
  //       geodesic: true,
  //       width: 5,
  //     );
  //
  //     setOfPolylines.add(polyline);
  //   });
  //
  //   LatLngBounds boundsLatLng;
  //   if(originLatLng.latitude > destinationLatLng.latitude &&
  //   originLatLng.longitude > destinationLatLng.longitude){
  //     boundsLatLng = LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
  //   }
  //   else if (originLatLng.longitude > destinationLatLng.longitude){
  //     boundsLatLng = LatLngBounds(southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude), northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude));
  //   }
  //   else if(originLatLng.latitude > destinationLatLng.longitude){
  //     boundsLatLng = LatLngBounds(southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude), northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude));
  //   }
  //   else{
  //     boundsLatLng = LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
  //   }
  //
  //   newTripGoogleMapController!.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 65));
  //
  //   Marker originMarker = Marker(
  //     markerId: MarkerId("originID"),
  //     position: originLatLng,
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //   );
  //
  //   Marker destinationMarker = Marker(
  //     markerId: MarkerId("destinationID"),
  //     position: destinationLatLng,
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //   );
  //
  //   setState(() {
  //     setOfMarkers.add(originMarker);
  //     setOfMarkers.add(destinationMarker);
  //   });
  //
  //   Circle originCircle = Circle(
  //     circleId: CircleId("originID"),
  //     fillColor: Colors.green,
  //     radius: 17,
  //     strokeWidth: 3,
  //     strokeColor: Colors.white,
  //     center: originLatLng,
  //   );
  //
  //   Circle destinationCircle = Circle(
  //     circleId: CircleId("destinationID"),
  //     fillColor: Colors.green,
  //     radius: 17,
  //     strokeWidth: 3,
  //     strokeColor: Colors.white,
  //     center: destinationLatLng,
  //   );
  //
  //   setState(() {
  //     setOfCircles.add(originCircle);
  //     setOfCircles.add(destinationCircle);
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPadding),
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            markers: setOfMarkers,
            circles: setOfCircles,
            polylines: setOfPolylines,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newTripGoogleMapController = controller;

              setState(() {
                mapPadding = 350;
              });

              var driverCurrentLatLng = LatLng(16.033590, 108.222649);

              // var userPickUpLatLng = widget.userRideRequestDetail!.originLatLng;
              //
              // drawPolylineFromOriginToDestination(driverCurrentLatLng, userPickUpLatLng, darkTheme);
              //
              // getDriverLocationUpdatesAtRealTime();
            },
          )
        ],
      ),
    );
  }
}
