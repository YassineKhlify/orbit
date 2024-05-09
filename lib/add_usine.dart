import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddUsinePage extends StatefulWidget {
  @override
  _AddUsinePageState createState() => _AddUsinePageState();
}

class _AddUsinePageState extends State<AddUsinePage> {
  late TextEditingController _usineNameController;
  File? _image;
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _usineNameController = TextEditingController();
  }

  @override
  void dispose() {
    _usineNameController.dispose();
    super.dispose();
  }

  Future<void> _chooseImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Usine',          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18, // Adjust the font size as needed
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usineNameController,
              decoration: InputDecoration(
                labelText: 'Enter Usine Name',
              ),
            ),
            SizedBox(height: 16.0),
            _image == null
                ? Text('No image selected.')
                : Image.file(
              _image!,
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                minimumSize: Size(double.infinity, 0), // Set width to span horizontally

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                ),
              ),

              icon: Icon(Icons.image),
              onPressed: _chooseImage,
              label: Text('Choose Usine Image'),
            ),
            SizedBox(height: 16.0),
            Text("Select Usine Location : "),


            SizedBox(height: 16.0),

            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(36.63364352606837, 10.246481271254885),
                      zoom: 10.0,
                    ),
                    onTap: (LatLng latLng) {
                      setState(() {
                        _selectedLocation = latLng;
                        _markers.clear();
                        _markers.add(
                          Marker(
                            markerId: MarkerId('selected-location'),
                            position: _selectedLocation!,
                            infoWindow: InfoWindow(title: 'Selected Location'),
                          ),
                        );
                      });
                    },
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                  ),
                  if (_selectedLocation != null)
                    Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        color: Colors.white,
                        child: Text(
                          'Selected Location: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            FilledButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                minimumSize: Size(double.infinity, 0), // Set width to span horizontally

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                ),
              ),

              icon: Icon(Icons.save),
              onPressed: () {
                // Save usine with entered data and selected location
                // For example:
                // _saveUsine(_usineNameController.text, _image, _selectedLocation);
              },
              label: Text('Save Usine'),
            ),
          ],
        ),
      ),
    );
  }
}
