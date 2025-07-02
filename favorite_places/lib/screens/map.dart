import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location =
          const PlaceLocation(latitude: 37, longitude: -122, address: ''),
      this.isSelecting = true});

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.isSelecting ? 'Pick your location' : 'Your location'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.save),
              )
          ]),
      body: GoogleMap(
        onTap: !widget.isSelecting ? null : (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        //  {} defines a set, it is a pair ov values, not accepts duplicates
        markers: (_pickedLocation == null && widget.isSelecting) ? {} : {
          Marker(
            markerId: const MarkerId('m1'),
            // ?? bellow checks if var is null
            position: _pickedLocation ?? LatLng(widget.location.latitude, widget.location.longitude),
          )
        },
      ),
    );
  }
}
