
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartsPage extends StatelessWidget {
  final String receivedMessage;
  final String request;

  const ChartsPage({Key? key, required this.receivedMessage, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parse the received JSON message
    final Map<String, dynamic> json = jsonDecode(receivedMessage);
    final Map<String, dynamic> reqJson = jsonDecode(request);
    List<String> deviceLabels = [];
    for (var device in reqJson['devices']) {
      deviceLabels.add(device['label']);
    }


    // Use the JSON data to display charts
    // Example: Create charts using the received JSON data
    final List<dynamic> data = json['data'];


    return Scaffold(

      body:  Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                children: [
                  Icon(Icons.bar_chart,
                    size: 35,),
                  SizedBox(width: 10,),
                  Text("Analytics",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),)
                ],
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sensors,
                            size: 30,),
                          SizedBox(width: 10,),
                          Text("Devices : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8.0, // Horizontal spacing between labels
                        runSpacing: 8.0, // Vertical spacing between lines
                        children: deviceLabels.map((label) {
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.deepPurple,
                            ),
                            child: Text(
                              " ⦿ $label",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width, // or specify a fixed width
                              height: MediaQuery.of(context).size.height, // or specify a fixed height

                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  // Prevent ListView from scrolling independently


                                  shrinkWrap: true,
                                  itemCount: filteredStations.length,
                                  itemBuilder: (context,index){
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),

                                                child: Image.network(
                                                  "https://orbitsmart.energy${filteredStations[index]["station_image"]}",
                                                  width: double.infinity, // Adjust as needed
                                                  height: 170,  // Adjust as needed
                                                  fit: BoxFit.cover,
                                                ),
                                              ) ,
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 8),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [ Colors.transparent,Colors.black.withOpacity(0.8)],
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        // Stroked text as border.
                                                        Text(
                                                          'Pates Warda Trigeneration',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            foreground: Paint()
                                                              ..style = PaintingStyle.stroke
                                                              ..strokeWidth = 6
                                                              ..color = Colors.black,
                                                          ),
                                                        ),
                                                        // Solid text as fill.
                                                        Text(
                                                          'Pates Warda Trigeneration',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Maintain aspect ratio)

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Container(

                                            margin: EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 10
                                            ),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.grey[200]
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.bolt,
                                                  color: Colors.orange,
                                                  size: 23,),
                                                SizedBox(width: 10,),
                                                Text("Energy",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                SizedBox(width: 40,),
                                                Text(currentMonth),
                                                SizedBox(width: 20,),

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
                                                    Text("625.212 MWh",style: TextStyle(fontSize: 13),),
                                                    SizedBox(height: 2,),
                                                    Text("42.869 MWh",style: TextStyle(fontSize: 13),),


                                                  ],
                                                )


                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.grey[200]
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.local_fire_department,
                                                  color: Colors.deepPurple,
                                                  size: 23,),
                                                SizedBox(width: 10,),
                                                Text("Gas",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                SizedBox(width: 65,),
                                                Text(currentMonth),
                                                SizedBox(width: 20,),
                                                Text("473656.00 Nm3",style: TextStyle(fontSize: 13),),





                                              ],
                                            ),
                                          ),
                                          OverflowBar(
                                            children: [
                                              ElevatedButton.icon(
                                                  style: ButtonStyle(
                                                    elevation: MaterialStateProperty.all<double>(0), // Set elevation to 0 for transparency

                                                  ),

                                                  icon: Icon(Icons.remove_red_eye),
                                                  onPressed: () {

                                                  },
                                                  label: Text("View")),
                                              ElevatedButton.icon(
                                                  style: ButtonStyle(
                                                    elevation: MaterialStateProperty.all<double>(0), // Set elevation to 0 for transparency

                                                  ),


                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    showDialog(context: context, builder: (BuildContext context){
                                                      return(
                                                          AlertDialog(
                                                            title: Text('Edit Pates Warda Trigeneration'),
                                                            content: Container(
                                                              height: 250,
                                                              child: Column(
                                                                children: [
                                                                  TextField(
                                                                    controller: _stationNameController,
                                                                    decoration: InputDecoration(
                                                                      labelText: 'Enter Station Name',
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
                                                                    label: Text('Choose Station Image'),
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

                                                  },
                                                  label: Text("Edit")),
                                              ElevatedButton.icon(
                                                  style: ButtonStyle(
                                                    overlayColor: MaterialStateProperty.all<Color>(Colors.red.withOpacity(0.2)), // Adjust opacity level as needed
                                                    elevation: MaterialStateProperty.all<double>(0), // Set elevation to 0 for transparency

                                                  ),
                                                  icon: Icon(Icons.delete,
                                                    color: Colors.red,),
                                                  onPressed: () {
                                                    showDialog(context: context, builder: (BuildContext context){
                                                      return(
                                                          AlertDialog(
                                                            title: Text('Delete Pates Warda Trigeneration'),
                                                            content: Text('Are you sure you want to delete "Pates Warda Trigeneration"?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                },
                                                                child: Text('Cancel'),
                                                              ),
                                                              TextButton(
                                                                style: ButtonStyle(
                                                                  overlayColor: MaterialStateProperty.all<Color>(Colors.red.withOpacity(0.2)), // Adjust opacity level as needed

                                                                ),

                                                                onPressed: () {
                                                                },
                                                                child: Text('Delete',style: TextStyle(color: Colors.red),),
                                                              ),
                                                            ],
                                                          ));
                                                    });

                                                  },
                                                  label: Text("Delete",style: TextStyle(color: Colors.red),))


                                            ],
                                          )



                                        ],
                                      ),
                                    );
                                  }
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.business_rounded,
                                        size: 30,),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Stations :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20, // Adjust the font size as needed
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 25,),
                                  Row(
                                    children: [
                                      Icon(Icons.auto_graph,
                                        size: 30,),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Graphics & Details :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20, // Adjust the font size as needed
                                        ),
                                      ),
                                    ],
                                  ),




                                ],
                              ),
                            ),
                            Container(

                              child:TabBar(

                                  isScrollable: true,
                                  controller: _tabController,
                                  tabs: [
                                    Tab(
                                      text: "Imported Energy",
                                    ),
                                    Tab(
                                      text: "Exported Energy",
                                    ),
                                    Tab(
                                      text: "Gas",
                                    )


                                  ]
                              ),
                            ),
                            Container(
                              height: 500,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child:  Column(
                                      children: [
                                        SizedBox(height: 20,),
                                        Container(
                                          height: 270,
                                          child: BarChart(
                                            BarChartData(
                                              gridData: FlGridData(
                                                show: true,
                                                drawVerticalLine: false, // Set to false to hide vertical grid lines
                                              ),
                                              maxY: 14,
                                              // Bar groups data
                                              groupsSpace: 12,
                                              barTouchData: BarTouchData(
                                                enabled: true, // Disable touch interaction
                                              ),
                                              titlesData: FlTitlesData(
                                                // Titles on x-axis and y-axis


                                                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                              ),
                                              borderData: FlBorderData(
                                                border: Border.all(color: Colors.black, width: 0),
                                              ),
                                              barGroups: data
                                                  .asMap()
                                                  .map((index, value) => MapEntry(
                                                index,
                                                BarChartGroupData(
                                                  x: index,
                                                  barRods: [
                                                    BarChartRodData(
                                                        color: Colors.deepPurple,
                                                        fromY: 0, toY: value,
                                                        width: 12,
                                                        borderRadius: BorderRadius.circular(4)
                                                      // Bar color
                                                    ),
                                                  ],
                                                ),
                                              ))
                                                  .values
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            horizontalMargin: 10,
                                            columns: [
                                              DataColumn(label: Text('Station')),
                                              DataColumn(label: Text('Min (kWh)')),
                                              DataColumn(label: Text('Max (kWh)')),
                                              DataColumn(label: Text('Average (kWh)')),
                                              DataColumn(label: Text('Total (kWh)')),
                                            ],
                                            rows: _stations.map((station) => DataRow(cells: [
                                              DataCell(Text(station.name)),
                                              DataCell(Text(station.min.toStringAsFixed(2))),
                                              DataCell(Text(station.max.toStringAsFixed(2))),
                                              DataCell(Text(station.average.toStringAsFixed(2))),
                                              DataCell(Text(station.total.toStringAsFixed(2))),
                                            ])).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text("data"),
                                  Text("yass")



                                ],

                              ),
                            ),
                          ]
                      ),


                    ],
                  ),
                ),
              ),

           ],
          ),
        ),
      ),
    );
  }
}
