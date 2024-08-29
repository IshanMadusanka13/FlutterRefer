import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class OsmflutterEx extends StatefulWidget {
  @override
  _OsmflutterExState createState() => _OsmflutterExState();
}

class _OsmflutterExState extends State<OsmflutterEx> {
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController.withUserPosition(
        trackUserLocation: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ));

    // Add listener for map long tapping
    controller.listenerMapLongTapping.addListener(() {
      if (controller.listenerMapLongTapping.value != null) {
        GeoPoint geoPoint = controller.listenerMapLongTapping.value!;
        _handleLongPress(geoPoint);
      }
    });
  }

  Future<void> distanceFind() async {
    RoadInfo roadInfo = await controller.drawRoad(
      GeoPoint(latitude: 6.903966633373827, longitude: 79.95509373164919),
      GeoPoint(latitude: 6.877236853781554, longitude: 79.98997897353007),
      roadType: RoadType.car,
      roadOption: const RoadOption(
        roadWidth: 10,
        roadColor: Colors.blue,
        zoomInto: true,
      ),
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coordinates'),
        content: Text(
            "${roadInfo.distance}km and ${roadInfo.duration}sec ${roadInfo.instructions}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleLongPress(GeoPoint geoPoint) {
    print("Latitude: ${geoPoint.latitude}, Longitude: ${geoPoint.longitude}");
    // You can also use a dialog or other UI elements to show the coordinates
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coordinates'),
        content: Text(
            "Latitude: ${geoPoint.latitude}, Longitude: ${geoPoint.longitude}"),
        actions: [
          TextButton(
            onPressed: () => {Navigator.of(context).pop(), distanceFind()},
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dead Men Tell No Tales'),
      ),
      body: OSMFlutter(
        controller: controller,
        osmOption: OSMOption(
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: const ZoomOption(
            initZoom: 8,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),
          staticPoints: [
            StaticPositionGeoPoint(
              '1',
              const MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
              [
                GeoPoint(
                    latitude: 6.903966633373827, longitude: 79.95509373164919),
                GeoPoint(
                    latitude: 6.877236853781554, longitude: 79.98997897353007)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
