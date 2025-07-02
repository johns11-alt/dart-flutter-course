import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        child: Text(
          'No location chosen', 
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface
          ),
          ),
      ),
      Row( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        TextButton.icon(
          onPressed: (){}, 
          label: Text('Get your location'),
          icon: const Icon(Icons.location_on),
          ),
          TextButton.icon(
          onPressed: (){}, 
          label: Text('Select on map'),
          icon: const Icon(Icons.map),
          ),
      ],)
    ],);
  }
}