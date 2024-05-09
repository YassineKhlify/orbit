import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class StationConsumption {
  final String name;
  final double min;
  final double max;
  final double average;
  final double total;


  StationConsumption(this.name, this.min, this.max, this.average, this.total);
}
List<StationConsumption> _stations = [
  StationConsumption('Pate Warda Trigénération', 1703.00, 66517.00, 22424.46, 627885.00),
  // Add more data as needed
];

class UsineConsumption extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> usineData;

  UsineConsumption({required this.usineData,required this.data});

  @override
  State<UsineConsumption> createState() => _UsineConsumptionState();
}

class _UsineConsumptionState extends State<UsineConsumption> with TickerProviderStateMixin{
  late TextEditingController _stationNameController;
  File? _image;
  @override
  void initState() {
    super.initState();
    _stationNameController = TextEditingController();
  }

  @override
  void dispose() {
    _stationNameController.dispose();
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
    final userData = widget.data;
    // Extract station data
    final stationsData = userData['station'];

    // Initialize a list to store filtered stations
    List<dynamic> filteredStations = [];

    // Iterate over station data entries
    stationsData.forEach((value) {
      // Check if the station's usine_id is "x", then add it to the filtered stations list
      if (value['usine_id'] == widget.usineData["_id"]) {
        filteredStations.add(value);
      }
    });
    print("yassssssssssss");
    print(filteredStations[0]);

    // Print the filtered stations
    filteredStations.forEach((station) {
      print("Station Name: ${station['station_name']}, Usine ID: ${station['usine_id']}");
    });
    // Print the filtered stations

    // Iterate over station data

    final List<double> data = [5, 8, 10, 12, 6];


    TabController _tabController = TabController(length: 3, vsync: this);

    DateTime now = DateTime.now();

    // List of month names
    List<String> monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];

    // Get current month
    String currentMonth = monthNames[now.month - 1];
    // Get the current month
    int currentMonth1 = now.month;
    int currentYear = now.year;

// Get the number of days in the current month
    int daysInMonth = DateTime(currentYear, currentMonth1 + 1, 0).day;

// Generate a list of dates for each day of the current month
    List<DateTime> dates = [];
    for (int i = 1; i <= daysInMonth; i++) {
      dates.add(DateTime(currentYear, currentMonth1, i));
    }

// Generate bottom titles using the dates
    List<String> bottomTitles = [];
    for (DateTime date in dates) {
      bottomTitles.add('${date.day}');
    }

// Create bottom titles for each week
    List<String> weekBottomTitles = [];
    for (int i = 0; i < bottomTitles.length; i += 7) {
      int endIndex = i + 6 < bottomTitles.length ? i + 6 : bottomTitles.length - 1;
      weekBottomTitles.add('${bottomTitles[i]} - ${bottomTitles[endIndex]}');
    }

// Use weekBottomTitles in the FlTitlesData


    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.usineData['usine_name']} Consumption',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18, // Adjust the font size as needed
          ),),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 15,),
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
        
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: 390,// or specify a fixed width
        
        
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // Prevent ListView from scrolling independently
                  shrinkWrap: true,
        
        
                  itemCount: filteredStations.length,
                  itemBuilder: (context,index){
                    return Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.87 , // Adjust as needed
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
                                              '${filteredStations[index]['station_name']}',
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
                                              '${filteredStations[index]["station_name"]}',
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
                                    top: 5,
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
                                    SizedBox(width: 7,),
                                    Text("Energy",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    SizedBox(width: 37,),
                                    Text(currentMonth),
                                    SizedBox(width: 15,),
        
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
                              Row(
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
                                                title: Text('Edit ${filteredStations[index]["station_name"]}'),
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
                                      label: Text("Edit",style:TextStyle(fontSize: 12))),
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
                                      label: Text("Delete",style: TextStyle(color: Colors.red,fontSize: 12),))
        
        
                                ],
                              )
        
        
        
                            ],
                          ),
                        ),
                        SizedBox(width: 10,)
                      ],
                    );
                  }
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
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
                )
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
          ],
        ),
      ),
    );
  }
  // Helper function to convert Station object to DataRow

}
