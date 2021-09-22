import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps/widgets/map_bottom_pill.dart';
import 'package:google_maps/widgets/map_user_badge.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(38.423151, 27.13885);
const LatLng DEST_LOCATION = LatLng(38.420284, 27.14101);

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  static late BitmapDescriptor sourceIcon;
  static late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();

  double pinPillPosition = PIN_INVISIBLE_POSITION;

  late LatLng currentLocation;
  late LatLng destinationLocation;
  bool userBadgeSelected = true;

  Set<Polyline> _polylines = Set<Polyline>();

  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  @override
  void initState() {
    super.initState();

    polylinePoints = PolylinePoints();

    // set up initial location
    this.setInitialLocation();

    // set up the marker icons
    this.setSourceAndDestinationMarkerIcons();
  }

  void setSourceAndDestinationMarkerIcons() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              devicePixelRatio: 4.0,
            ),
            'assets/image/source_pin.png')
        .then((value) => sourceIcon = value);
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          devicePixelRatio: 2.0,
        ),
        'assets/image/destination_pin.png');
  }

  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        target: SOURCE_LOCATION,
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                onTap: (LatLng loc) {
                  //tapping on the map will dismiss the bottom pill
                  setState(() {
                    this.pinPillPosition = PIN_INVISIBLE_POSITION;
                    this.userBadgeSelected = false;
                  });
                },
                polylines: _polylines,
                initialCameraPosition: initialCameraPosition,
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: false,
                tiltGesturesEnabled: true,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  showPinsOnMap();
                  // showPinsOnMap();
                },
              ),
            ),
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: MapUserBadge(
                isSelected: userBadgeSelected,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: 0,
              right: 0,
              bottom: this.pinPillPosition,
              child: MapBottomPill(),
            ),
          ],
        ),
      ),
    );
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
          infoWindow: InfoWindow(title: "Me"),
          markerId: MarkerId('sourcePin'),
          position: currentLocation,
          icon: sourceIcon,
          onTap: () {
            setState(() {
              this.pinPillPosition = PIN_INVISIBLE_POSITION;
              this.userBadgeSelected = true;
              _polylines.clear();
              polylineCoordinates.clear();
            });
          }));
      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationLocation,
          icon: destinationIcon,
          onTap: () {
            setState(() {
              this.pinPillPosition = PIN_VISIBLE_POSITION;
              this.userBadgeSelected = false;
              setPolylines();
            });
          }));
    });
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "YOUR_API_KEY",
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));
    if (result.status == "OK") {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
          Polyline(
            width: 5,
            polylineId: PolylineId("polyline"),
            color: Color(0xFF08A5C8),
            points: polylineCoordinates,
          ),
        );
      });
    }
  }
}
