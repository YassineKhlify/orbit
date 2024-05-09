import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:orbit/usine_consumption.dart';

class UsineDetails extends StatelessWidget {
  late GoogleMapController mapController;
  final LatLng initialLocation = LatLng(36.63364352606837, 10.246481271254885);
  final Map<String, dynamic> usineData;
  final Map<String, dynamic> data;

  final String usineName;

  UsineDetails({required this.usineData,required this.usineName,required this.data});


  @override
  Widget build(BuildContext context) {
    final LatLng initialLocation = LatLng(36.63364352606837, 10.246481271254885);

    final LatLng markerLocation = LatLng(usineData['position']['lat'],usineData['position']['lng']);
    print(markerLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text(usineData["usine_name"],style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18, // Adjust the font size as needed
        ),),
        actions: [
          Padding(padding: EdgeInsets.all(11),
          child:           FilledButton(
            child: Text("View Details"),
            style: ElevatedButton.styleFrom(
              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
              ),
            ),

            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>UsineConsumption(
                usineData: usineData,
                data: data,
              )));
            },))
        ],
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
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

                      SizedBox(
                        width: double.infinity,
                        height: 150, // Adjust height as needed
                        child:  Image.network('https://orbitsmart.energy${usineData["usine_image"]}'),
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

                      Divider(
                        height: 1,
                        color: Colors.grey[350],
                        thickness: 1,
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Text("Energy Cost:",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Column(
                            children: [
                              Text("Active Energy"),
                              Text("Imported"),
                            ],
                          ),
                          SizedBox(width: 40,),
                          Column(
                            children: [
                              Text("1047.48"),
                              Text("/50000.00 TND"),
                            ],
                          ),


                        ],
                      ),
                      Container(
                        width: 225,

                        margin: EdgeInsets.all(10),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          backgroundColor: Colors.redAccent[300],
                          value: 1047.48/5000,
                          minHeight: 6,

                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          SizedBox(width: 65,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54,
                                    width: 2
                                )
                            ),
                            child: Icon(
                              Icons.file_copy_outlined,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(width: 100,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54,
                                    width: 2
                                )
                            ),
                            child: Icon(
                              Icons.bar_chart,
                              color: Colors.black54,

                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 12,),
                      Container(
                        width: 150,
                        child:                      Divider(
                          height: 1,
                          color: Colors.grey[350],
                          thickness: 1,
                        ),

                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Column(
                            children: [
                              Text("Active Energy"),
                              Text("Exported"),
                            ],
                          ),
                          SizedBox(width: 40,),
                          Column(
                            children: [
                              Text("51333.48"),
                              Text("/50000.00 TND"),
                            ],
                          ),


                        ],
                      ),
                      Container(
                        width: 225,

                        margin: EdgeInsets.all(10),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(20),

                          color: Colors.green,
                          value: 10,
                          minHeight: 6,

                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          SizedBox(width: 65,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54,
                                    width: 2
                                )
                            ),
                            child: Icon(
                              Icons.file_copy_outlined,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(width: 100,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54,
                                    width: 2
                                )
                            ),
                            child: Icon(
                              Icons.bar_chart,
                              color: Colors.black54,

                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 12,),
                      Container(
                        width: 150,
                        child:                      Divider(
                          height: 1,
                          color: Colors.grey[350],
                          thickness: 1,
                        ),

                      ),
                      SizedBox(height: 7),
                      Row(
                        children: [
                          SizedBox(width: 70,),
                          Text("Gas"),
                          SizedBox(width: 80,),
                          Column(
                            children: [
                              Text("1047.48"),
                              Text("/50000.00 TND"),
                            ],
                          ),


                        ],
                      ),
                      Container(
                        width: 225,
                        margin: EdgeInsets.all(10),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(20),

                          color: Colors.red,
                          backgroundColor: Colors.redAccent[300],
                          value: 1047.48/5000,
                          minHeight: 6,

                        ),
                      ),
                      SizedBox(height: 5,),

                      Row(
                        children: [
                          SizedBox(width: 65,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54,
                                    width: 2
                                )
                            ),
                            child: Icon(
                              Icons.file_copy_outlined,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(width: 100,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54,
                                    width: 2
                                )
                            ),
                            child: Icon(
                              Icons.bar_chart,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20), // Adjust spacing as needed
                      Divider(
                        height: 1,
                        color: Colors.grey[350],
                        thickness: 1,
                      ),
                      SizedBox(height: 20),
                      Text(
                          "Total Cost: 4952.1 TND",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: PieChart(
                              PieChartData(
                                startDegreeOffset: 180,
                                sectionsSpace: 0,
                                sections: [
                                  PieChartSectionData(
                                    value: 0.48/2,
                                    color: Colors.orange,
                                    title: '48%',
                                    radius: 60,
                                    titleStyle: TextStyle(color: Colors.white),

                                  ),
                                  PieChartSectionData(
                                    value: 0.09/2,
                                    color: Colors.green,
                                    title: '9%',
                                    radius: 60,
                                    titleStyle: TextStyle(color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    value: 0.29/2,
                                    color: Colors.red,
                                    title: '29%',
                                    radius: 60,
                                    titleStyle: TextStyle(color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    value: 0.13/2,
                                    color: Colors.purple,
                                    title: '13%',
                                    radius: 60,
                                    titleStyle: TextStyle(color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    value: 0.5,
                                    color: Colors.white,
                                    title: '13%',
                                    radius: 60,
                                    titleStyle: TextStyle(color: Colors.white),
                                  ),












                                ],
                                borderData: FlBorderData(show: false),
                                centerSpaceRadius: 70,
                              ),
                              swapAnimationDuration: Duration(milliseconds: 800),
                              swapAnimationCurve: Curves.easeInOutBack,
                            ),
                          ),
                          Positioned(
                            bottom: 35,
                              left: 70,
                              child: Column(

                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 15, // Adjust size as needed
                                        height: 15, // Adjust size as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Text("Gas")
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 15, // Adjust size as needed
                                        height: 15, // Adjust size as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Text("Active Energy Exported")
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 15, // Adjust size as needed
                                        height: 15, // Adjust size as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Text("Active Energy Imported")
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 15, // Adjust size as needed
                                        height: 15, // Adjust size as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Text("Reactive Energy Imported")
                                    ],
                                  ),
                                  SizedBox(height: 10,),


                                ],
                              )
                          )

                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[350],
                        thickness: 1,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Total Emissions: 23325.78 (KgCO2)",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset("assets/co2.png"),
                      Divider(
                        height: 1,
                        color: Colors.grey[350],
                        thickness: 1,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Usine Location :",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                          width: 400, // Adjust width as needed
                          height:200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          // Adjust height as needed
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: initialLocation,
                              zoom: 8,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                              mapController.animateCamera(CameraUpdate.newLatLng(markerLocation));
                            },
                            markers: {
                              Marker(
                                markerId: MarkerId('marker_id'),
                                position: markerLocation,
                                infoWindow: InfoWindow(title: 'Your Marker Title'),
                                icon: BitmapDescriptor.defaultMarker,
                              ),
                            },
                          )
                      ),
                      SizedBox(height: 20),










                    ],
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 3,
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      iconSize: 20,
                      onPressed: () {
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

}
