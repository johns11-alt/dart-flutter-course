import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:favorite_places/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:favorite_places/screens/map.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectlocation});

  final void Function(PlaceLocation location) onSelectlocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;

  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    const apiKey = 'AIzaSyCqHkKIk7LFJuK7_Cc0rP5isCgGuJG7Bok';

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=$apiKey';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    const apiKey = 'AIzaSyCqHkKIk7LFJuK7_Cc0rP5isCgGuJG7Bok';
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
          latitude: latitude, longitude: longitude, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectlocation(_pickedLocation!);
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;
    const apiKey = 'AIzaSyCqHkKIk7LFJuK7_Cc0rP5isCgGuJG7Bok';

    if (lat == null || lng == null) {
      return;
    }

    _savePlace(lat, lng);

    void selectOnMap() async {
      final pickedLocation =
          await Navigator.of(context).push<LatLng>(MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ));

      if (pickedLocation == null) {
        return;
      }
      _savePlace(pickedLocation.latitude, pickedLocation.longitude);
    }

    
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(locationImage,
          fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.2))),
            child: previewContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text('Get your location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Select on map'),
              icon: const Icon(Icons.map),
            ),
          ],
        )
      ],
    );
  }
}
