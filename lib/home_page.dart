import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:orbit/add_device.dart';
import 'package:orbit/login_page.dart';
import 'package:orbit/testai.dart';
import 'package:orbit/usine_details.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:io';
import 'package:swipe_to/swipe_to.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'add_usine.dart';
import 'analytics_page.dart';
import 'notification_listener.dart' as MyNotification;

class HomePage extends StatefulWidget {
  final String id;
  final String userName;

  HomePage({required this.id,required this.userName});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _newUsineNameController;

  File? _image1;




  Future<void> _chooseImage1() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image1 = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    late GoogleMapController _mapController;
    LatLng? _selectedLocation;
    Set<Marker> _markers = {};
    final MyNotification.NotificationListener _notificationListener = MyNotification.NotificationListener(
        id: widget.id
    );
    //_notificationListener.startListening();

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showNotificationBottomSheet(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.device_unknown),
            onPressed: (){

            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            DrawerHeader(

              child: Image.asset(
                "assets/orbit.png",


              ),
            ),
            FilledButton.icon(
              style: ElevatedButton.styleFrom(
               backgroundColor: Colors.blue, elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Adjust border radius as needed
              ),// Set the accent color
            ),
              onPressed: (){},
                label: Text("Mailing"), icon: Icon(Icons.mail),),
            SizedBox(height: 10,),
            FilledButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust border radius as needed
                ),// Set the accent color
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>AnalyticsPage(id: widget.id)));
                // Add functionality for Item 1

              },
              label: Text("Analytics"), icon: Icon(Icons.bar_chart),),
            SizedBox(height: 10,),
            FilledButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust border radius as needed
                ),// Set the accent color
              ),
              onPressed: (){

              },
              label: Text("Bill Simulation"), icon: Icon(Icons.monetization_on),),

            SizedBox(height: 10,),
            FilledButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust border radius as needed
                ),// Set the accent color
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSeriesPredictionPage()));

              },
              label: Text("Predict Future Consumption"), icon: Icon(Icons.online_prediction),),
            SizedBox(height: 270,),
            FilledButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust border radius as needed
                ),// Set the accent color
              ),
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Sign Out'),
                      content: Text('Are you sure you want to sign out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                            //_signOut(); // Trigger sign-out action
                          },
                          child: Text('Sign Out'),
                        ),
                      ],
                    );
                  },
                );

              },
              label: Text("Sign out"), icon: Icon(Icons.logout),),






          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min

          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                  "Welcome back 🎉,\n${widget.userName} !",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20
              ),
              width: double.infinity, // Adjust width as needed
              height: 40, // Adjust height as needed
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AddUsinePage()));

                  // Add your onPressed logic here
                  print('Button pressed');
                },
                icon: Icon(Icons.add),
                label: Text('Add Usine',
                   // Adjust font size as needed
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),

            // Static content


            // Usine names from JSON
            Container(
              child: FutureBuilder(
                future: _connectToWebSocket(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
                    final List<dynamic> usines = data['usine'];
                    final List<dynamic> allDevices = data['devices'];
                    //final int connectedDevices = data['connectedDevices'];
                    //final int disconnectedDevices = data['disconnectedDevices'];
                    return Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Set the background color to white


                              border: Border.all(

                                color: Colors.grey[350]!, // Light grey color
                              ),
                              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed

                            ),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.factory,
                                      size: 27.0, // Adjust the size as needed
                                      color: Colors.black54, // Adjust the color as needed
                                    ),
                                    SizedBox(width: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left

                                      children: [
                                        Text(
                                          "${usines.length}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, // Make the text bold
                                            fontSize: 18.0, // Set the font size to 20
                                          ),
                                        ),
                                        Text("Usines"),
                                      ],
                                    ),


                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.devices,
                                      size: 27.0, // Adjust the size as needed
                                      color: Colors.black54, // Adjust the color as needed
                                    ),
                                    SizedBox(width: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                                      children: [
                                        Text(allDevices.length.toString(), style: TextStyle(fontWeight: FontWeight.bold,   fontSize: 18.0, )),// Set the font size to 20)  // Set the font size to 20),
                                        Text("Reserved Devices"),
                                      ],
                                    ),


                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.sensors,
                                      size: 27.0, // Adjust the size as needed
                                      color: Colors.black54, // Adjust the color as needed
                                    ),
                                    SizedBox(width: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left

                                      children: [
                                        Text(allDevices.length.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                        Text("Connected Devices"),
                                      ],
                                    ),


                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.sensors_off,
                                      size: 27.0, // Adjust the size as needed
                                      color: Colors.black54, // Adjust the color as needed
                                    ),
                                    SizedBox(width: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left

                                      children: [
                                        Text("0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                                        Text("Disconnected Devices"),
                                      ],
                                    ),


                                  ],
                                ),

                              ],
                            ),

                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently


                          shrinkWrap: true,
                          itemCount: usines.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UsineDetails(
                                  usineData: usines[index],
                                  usineName: usines[index]["usine_name"],
                                  data: data,
                                )));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  elevation: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Set the background color to white
                                      border: Border.all(
                                        color: Colors.grey[350]!, // Light grey color
                                      ),
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(padding: EdgeInsets.all(10.0),
                                          child:  Column(
                                            children: [
                                              SizedBox(height: 5,),
                                              Text(
                                                "${usines[index]["usine_name"]}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17, // Adjust the font size as needed
                                                ),
                                              ),
                                              SizedBox(height: 15), // Adjust spacing as needed
                                              Divider(
                                                height: 1,
                                                color: Colors.grey[350],
                                                thickness: 1,
                                              ),
                                              SizedBox(height: 10), // Adjust spacing as needed
                                              SizedBox(
                                                width: double.infinity,
                                                height: 150, // Adjust height as needed
                                                child:  Image.network('https://orbitsmart.energy${usines[index]["usine_image"]}'),
                                              ),
                                              SizedBox(height: 15), // Adjust spacing as needed
                                              SizedBox(height: 10,),
                                              Stack(
                                                children: [
                                                  Positioned(
                                                      top: 5,
                                                      right: 175,
                                                      child: Text("/")),
                                                  Row(
                                                    children: [

                                                      SizedBox(width: 10,),
                                                      Icon(
                                                        Icons.bolt,
                                                        color: Colors.green,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [


                                                          Text("Active Energy",style: TextStyle(fontWeight: FontWeight.bold)),
                                                          Text("Month", style: TextStyle(fontSize: 14),),
                                                        ],
                                                      ),
                                                      SizedBox(width: 60,),
                                                      Column(
                                                        children: [

                                                          Icon(
                                                            Icons.arrow_upward,
                                                            color: Colors.green,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            Icons.arrow_downward,
                                                            color: Colors.red,
                                                            size: 20,
                                                          ),


                                                        ],
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          Text("132035.0 kWh",style: TextStyle(fontSize: 13),),
                                                          SizedBox(height: 2,),
                                                          Text("3589.0 kWh",style: TextStyle(fontSize: 13),),


                                                        ],
                                                      )





                                                    ],
                                                  )

                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Stack(
                                                children: [
                                                  Positioned(
                                                      top: 5,
                                                      right: 160,
                                                      child: Text("/")),
                                                  Row(
                                                    children: [

                                                      SizedBox(width: 10,),
                                                      Icon(
                                                        Icons.bolt,
                                                        color: Colors.blue,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [


                                                          Text("Reactive Energy",style: TextStyle(fontWeight: FontWeight.bold)),
                                                          Text("Month", style: TextStyle(fontSize: 14),),


                                                        ],
                                                      ),
                                                      SizedBox(width: 45,),
                                                      Icon(
                                                        Icons.arrow_downward,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Text("2035.0 kWh",style: TextStyle(fontSize: 13),),




                                                    ],
                                                  )

                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Stack(
                                                children: [
                                                  Positioned(
                                                      top: 5,
                                                      right: 242,
                                                      child: Text("/")),
                                                  Row(
                                                    children: [

                                                      SizedBox(width: 10,),

                                                      Icon(
                                                        Icons.local_fire_department,
                                                        color: Colors.orange,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [


                                                          Text("Gas",style: TextStyle(fontWeight: FontWeight.bold)),
                                                          Text("Month", style: TextStyle(fontSize: 14),),
                                                        ],
                                                      ),
                                                      SizedBox(width: 113,),
                                                      Text("25533.00 Nm3",style: TextStyle(fontSize: 13),),


                                                    ],
                                                  )

                                                ],
                                              ),
                                              SizedBox(height: 20,),









                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            right: 10,
                                            top: 3,
                                            child: IconButton(
                                              icon: Icon(Icons.edit),
                                              iconSize: 20,
                                              onPressed: () {
                                                showDialog(context: context, builder: (BuildContext context){
                                                  return(
                                                      AlertDialog(
                                                        title: Text('Edit ${usines[index]["usine_name"]}'),
                                                        content: Container(
                                                          height: 500,
                                                          child: Column(
                                                            children: [
                                                              TextField(
                                                                controller: _newUsineNameController,
                                                                decoration: InputDecoration(
                                                                  labelText: 'Enter Usine Name',
                                                                ),
                                                              ),
                                                              SizedBox(height: 16.0),
                                                              _image1 == null
                                                                  ? Text('No image selected.')
                                                                  : Image.file(
                                                                _image1!,
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
                                                                onPressed: _chooseImage1,
                                                                label: Text('Choose Usine Image'),
                                                              ),
                                                              SizedBox(height: 15,),
                                                              Text("Select Usine Location : "),
                                                              SizedBox(height: 15,),

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

                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(); // Close the dialog
                                                            },
                                                            child: Text('Cancel'),
                                                          ),
                                                          TextButton.icon(
                                                            icon: Icon(Icons.save),


                                                            onPressed: () {
                                                            },
                                                            label: Text('Save'),
                                                          ),
                                                        ],
                                                      ));
                                                });

                                                // Add your onPressed functionality here
                                                // This function will be called when the button is pressed
                                                print('Settings button pressed');
                                              },
                                            )
                                        ),
                                        Positioned(
                                            left: 10,
                                            top: 3,
                                            child: IconButton(
                                              icon: Icon(Icons.delete,color: Colors.red,),
                                              iconSize: 20,
                                              onPressed: () {
                                                showDialog(context: context, builder: (BuildContext context){
                                                  return(
                                                      AlertDialog(
                                                        title: Text('Delete ${usines[index]["usine_name"]}'),
                                                        content: Text("Are you sure you want to delete ${usines[index]["usine_name"]} ?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(); // Close the dialog
                                                            },
                                                            child: Text('Cancel'),
                                                          ),
                                                          TextButton.icon(
                                                            icon: Icon(Icons.delete,color: Colors.red,),


                                                            onPressed: () {
                                                            },
                                                            label: Text('Delete',style: TextStyle(color: Colors.red),),
                                                          ),
                                                        ],
                                                      ));
                                                });

                                                // Add your onPressed functionality here
                                                // This function will be called when the button is pressed
                                                print('Settings button pressed');
                                              },
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),






                      ],
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  late WebSocketChannel channel;

  bool isLoading = true;

  Future<Map<String, dynamic>> _connectToWebSocket() {
    final String superUserId = widget.id;
    print("aaaaaaaaaaaaaaaaaaaaaaa");
    print(widget.id);
    //650aa3373def3736fdb3b666 sartex
    //651c2d1f11c488aed1d86344 warda

    Completer<Map<String, dynamic>> completer = Completer();

    IOWebSocketChannel channel =
    IOWebSocketChannel.connect('wss://orbitsmart.energy/Mongo/get_analyse_devices_by_user_id');

    // Sending the super user id when socket is opened
    channel.sink.add('{"super_user_id": "$superUserId"}');

    // Listening for incoming messages
    channel.stream.listen(
          (message) {
        // Parse the message as JSON
        Map<String, dynamic> parsedMessage = json.decode(message);
        if (parsedMessage != null) {
          // Access individual properties
          String alerte = parsedMessage['alerte'];
          Map<String, dynamic> data = parsedMessage['data'];

          if (alerte != null && data != null) {
            print("Received data from WebSocket:");
            print(data["usine"]);
            completer.complete(data); // Completing the future with the received data
          } else {
            print("Received message does not contain expected fields.");
          }
        } else {
          print("Received message is not valid JSON.");
        }
      },
      onError: (error) {
        print("Error occurred: $error");
        completer.completeError(error); // Completing the future with an error
      },
      onDone: () {
        print("WebSocket connection closed");
        // Handle WebSocket connection closed
      },
    );

    return completer.future; // Returning the future
  }
  @override
  void dispose() {
    channel.sink.close();
    _newUsineNameController.dispose();

    super.dispose();
  }
  void initState() {
    super.initState();
    _connectToWebSocket();
    _newUsineNameController = TextEditingController();


  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://orbitsmart.energy/read/get_client_info'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load data');
    }

  }


  void _showNotificationBottomSheet(BuildContext context) async {
    final notifications = await fetchNotifications();
    // Fetch notifications from the new URL
    final nots = notifications.toList();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(

          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Notifications:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: nots.length,
                  itemBuilder: (context, index) {
                    final notification = nots[index]['notification'];
                    final device = nots[index]['device'];
                    final color;
                    if (notification['level']=='warn'){
                      color=Colors.orange;
                    }else color= Colors.red;
                    return Column(
                      children: [
                        SwipeTo(
                            iconOnRightSwipe: Icons.delete,
                            key: UniqueKey(),
                            iconOnLeftSwipe: Icons.arrow_forward,
                            onRightSwipe: (details) {
                              print("\n Left Swipe Data --> ");
                            },
                            swipeSensitivity: 10,
                            child: Card(
                              elevation: 3,
                              child: ExpansionTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.notifications),
                                    SizedBox(width: 5,),
                                    Expanded(child: ListTile(
                                      title: Text(notification['name']),
                                      subtitle: Text(device['device_name']),
                                      trailing: Text('Level: ${notification['level']}',
                                          style : TextStyle(
                                              color:color
                                          )
                                      ),
                                    )
                                    )
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            SizedBox(width: 5,),
                                            Text("Zone : ${nots[index]['zone']['zone_name']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.smartphone),
                                            SizedBox(width: 5,),
                                            Text("Device : ${nots[index]['device']['device_name']}",
                                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Text("${notification['parameter']} = ${notification['value'].toStringAsFixed(3)}",
                                          style: TextStyle(color: color,fontWeight: FontWeight.bold,fontSize: 16),),
                                        //SizedBox(height: 5,),
                                        //Row(
                                        //  children: [
                                         //   Icon(Icons.compare_arrows),
                                        //    SizedBox(width: 5,),
                                        //    Text("Threshold : [${notification['warn_value']},${notification['crit_value']}]",
                                        //      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                        //  ],
                                        //),




                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                        SizedBox(height: 10,),
                      ],
                    );
                  },
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  Future<List<dynamic>> fetchNotifications() async {
    final response = await http.get(Uri.parse('https://orbitsmart.energy/notification/settings/active/${widget.id}'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load notifications');
    }
  }
}
