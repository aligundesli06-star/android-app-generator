```dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const WalkBuddyApp());
}

class WalkBuddyApp extends StatelessWidget {
  const WalkBuddyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalkBuddy',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WalkBuddyHome(),
    );
  }
}

class WalkBuddyHome extends StatefulWidget {
  const WalkBuddyHome({Key? key}) : super(key: key);

  @override
  State<WalkBuddyHome> createState() => _WalkBuddyHomeState();
}

class _WalkBuddyHomeState extends State<WalkBuddyHome> {
  int _steps = 0;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _latitude = 0;
  double _longitude = 0;
  GoogleMapController? _googleMapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    _markers.add(
      Marker(
        markerId: const MarkerId('_current_location'),
        position: LatLng(_latitude, _longitude),
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalkBuddy'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text('Find Walking Buddies'),
                  ),
                  const SizedBox(height: 16),
                  Text('Daily Steps: $_steps'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _steps++;
                      });
                    },
                    child: const Text('Add Step'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(_latitude, _longitude),
                zoom: 14,
              ),
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
```