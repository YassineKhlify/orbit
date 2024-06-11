import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:orbit/add_device.dart';
import 'package:orbit/edit_device.dart';
import 'package:orbit/view_device.dart';

class ViewStationPage extends StatefulWidget {

  final Map<String, dynamic> data;
  final Map<String, dynamic> stationData;

  ViewStationPage({required this.stationData,required this.data});

  @override
  State<ViewStationPage> createState() => _ViewStationPageState();
}

class _ViewStationPageState extends State<ViewStationPage> {
  late TextEditingController _zoneNameController;
  late TextEditingController _newZoneNameController;

  void initState() {
    super.initState();
    _zoneNameController = TextEditingController();
    _newZoneNameController = TextEditingController();

  }
  @override
  void dispose() {
    _zoneNameController.dispose();
    _newZoneNameController.dispose();


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final userData = widget.data;
    final zonesData = userData['zones'];
    final devicesData = userData['devices'];

    // Initialize a list to store filtered stations
    List<dynamic> filteredZones = [];
    List filteredDevices = [];
    List<String> zoneNames = [];

    // Iterate over station data entries
    zonesData.forEach((value) {
      // Check if the station's usine_id is "x", then add it to the filtered stations list
      if (value['station_id'] == widget.stationData["_id"]) {
        filteredZones.add(value);
      }
    });


    print("yassssssssssss");

    // Print the filtered stations
    filteredZones.forEach((zone) {
      zoneNames.add(zone["zone_name"].toString());
      print("Zone Name: ${zone['zone_name']}, Usine ID: ${zone['station_id']}");
    });
    print("my zooooooooone namesssssss$zoneNames");
    // Print the filtered stations
    List<Color> generateRandomColors(int n) {
      Random random = Random();
      List<Color> colors = [];

      for (int i = 0; i < n; i++) {
        // Generate random RGB values
        int r = random.nextInt(256);
        int g = random.nextInt(256);
        int b = random.nextInt(256);

        // Create Color object with random RGB values
        Color color = Color.fromARGB(255, r, g, b);
        colors.add(color);
      }

      return colors;
    }
    int n = filteredZones.length;
    List<int> generateIntegersWithSum(int n, int sum) {
      Random random = Random();
      List<int> integers = List<int>.filled(n, 0);

      // Initialize each element with a random integer between 1 and sum / n
      for (int i = 0; i < n - 1; i++) {
        integers[i] = random.nextInt(sum ~/ n) + 1;
      }

      // The last element is the difference between the sum and the sum of the previous elements
      integers[n - 1] = sum - integers.sublist(0, n - 1).reduce((a, b) => a + b);

      return integers;
    }
    int sum = 100;

// Desired sum


    List<Color> randomColors = generateRandomColors(n);
    final List<String> bottomTitles = ['Mon.', 'Tue.', 'Wed.', 'Thu.', 'Fri.','Sat.','Sun.'];


    final List<double> barData = [1.8,2.0,1.1,1.5, 1.8, 2.0,2.1];



    // Iterate over station data
    return Scaffold(
      appBar: AppBar(
        title: Text('Station : ${widget.stationData["station_name"]}',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18, // Adjust the font size as needed
        ),),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(context: context,isScrollControlled: true, builder: (BuildContext context){
              filteredDevices.clear();
              for (var i=0;i<filteredZones.length;i++){
                print("object");
                var selectedZone = filteredZones[i];
                print(selectedZone["zone_name"]);
                print("iiiiiiiiiiiiii$i");
                var i2=0;


                filteredDevices.add([]);
                print(filteredDevices);
                devicesData.forEach((value){
                  if (value['zone_id'] == selectedZone["_id"]) {
                    filteredDevices[i].add(value);
                    i2++;
                  }
                });
              }
              return Container(
                height: 500,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on,size: 27,),
                        SizedBox(width: 5,),
                        Text("Zones :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        SizedBox(width: 93,),
                        FilledButton.icon(
                            onPressed: (){
                              showDialog(context: context, builder: (BuildContext context){

                                return(
                                    AlertDialog(
                                      title: Text('Add Zone'),
                                      content: Container(
                                        height: 80,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: _newZoneNameController,
                                              decoration: InputDecoration(
                                                labelText: 'Enter Zone Name',
                                              ),
                                            ),
                                            SizedBox(height: 16.0),

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
                          style: ElevatedButton.styleFrom(
                            elevation: 3,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                            ),
                          ),

                          label: Text("Add Zone"),
                          icon: Icon(Icons.add),
                        )

                      ],
                    ),
                    SizedBox(height: 5,),
                    Expanded(
                      child:ListView.builder(
                          itemCount: filteredZones.length,
                          itemBuilder: (context, index){

                            return Card(
                              elevation: 3,
                              child: ExpansionTile(

                                title: Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(width: 5,),
                                    Text(filteredZones[index]["zone_name"]),
                                  ],
                                ),
                                children: [
                                  Container(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: filteredDevices[index].length,
                                        itemBuilder: (context1, index1){

                                        return (
                                            Card(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.smartphone),
                                                    SizedBox(width: 5,),
                                                    Text(filteredDevices[index][index1]["device_name"].toString())
                                                  ],
                                                ),
                                              ),
                                        ));
                                        }),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 205,),
                                      IconButton(onPressed: (){
                                        showDialog(context: context, builder: (BuildContext context){
                                          return(
                                              AlertDialog(
                                                title: Text('Edit ${zoneNames[index]}'),
                                                content: Container(
                                                  height: 70,
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller: _zoneNameController,
                                                        decoration: InputDecoration(
                                                          labelText: 'Enter Zone Name',
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

                                      }, icon: Icon(Icons.edit)),
                                      IconButton(onPressed: (){
                                        showDialog(context: context, builder: (BuildContext context){
                                          return(
                                              AlertDialog(
                                                title: Text('Delete ${zoneNames[index]}'),
                                                content: Text('Are you sure you want to delete "${zoneNames[index]}"?'),
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

                                      }, icon: Icon(Icons.delete),color: Colors.red,),
                                    ],
                                  )

                                ],
                              ),
                            );
                          }
                      )
                      ,
                    )
                  ],
                ),
              );

            });
          }, icon: Icon(Icons.location_on)),

          IconButton(
              onPressed: (){
                showModalBottomSheet(context: context, isScrollControlled: true,builder: (BuildContext context){
                  filteredDevices.clear();
                  for (var i=0;i<filteredZones.length;i++){
                    print("object");
                    var selectedZone = filteredZones[i];
                    print(selectedZone["zone_name"]);
                    print("iiiiiiiiiiiiii$i");
                    var i2=0;


                    filteredDevices.add([]);
                    print(filteredDevices);
                    devicesData.forEach((value){
                      if (value['zone_id'] == selectedZone["_id"]) {
                        filteredDevices[i].add(value);
                        i2++;
                      }
                    });
                  }

                  return(
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 500,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.smartphone,size: 27,),
                            SizedBox(width: 5,),
                            Text("Devices :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(width: 69,),
                            FilledButton.icon(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>AddDevicePage(
                                      zoneNames: zoneNames
                                    )));

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),

                              label: Text("Add Device"),
                              icon: Icon(Icons.add),
                            )

                          ],
                        ),
                        SizedBox(height: 5,),
                        Expanded(
                          child:ListView.builder(
                              itemCount: filteredZones.length,
                              itemBuilder: (context, index){

                                return Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            SizedBox(width: 5,),
                                            Text(filteredZones[index]["zone_name"]),
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                        Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: filteredDevices[index].length,
                                              itemBuilder: (context1, index1){


                                                return (
                                                    Card(
                                                      child: Container(
                                                        height: 88,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(Icons.smartphone),
                                                                  SizedBox(width: 5,),
                                                                  Text(filteredDevices[index][index1]["device_name"].toString()),


                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SizedBox(width: 120,),
                                                                  IconButton(
                                                                      onPressed: (){
                                                                        showDialog(context: context, builder: (BuildContext context){
                                                                          return(
                                                                              AlertDialog(
                                                                                title: Text('Delete ${filteredDevices[index][index1]["device_name"]}'),
                                                                                content: Text('Are you sure you want to delete "${filteredDevices[index][index1]["device_name"]}"?'),
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
                                                                      icon: Icon(Icons.delete,color: Colors.red,)),
                                                                  IconButton(
                                                                      onPressed: () {
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditDevice(
                                                                            myDevice: filteredDevices[index][index1])));
                                                                      },
                                                                      icon: Icon(Icons.edit)),
                                                                  IconButton(
                                                                      onPressed: (){
                                                                        Navigator.push(context, MaterialPageRoute(builder:(context)=>ViewDevice(
                                                                          myDevice: filteredDevices[index][index1],
                                                                        ) ));
                                                                      },
                                                                      icon: Icon(Icons.remove_red_eye))

                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          )
                          ,
                        ),


                      ],
                    ),
                  )
                  );
                });
              },
              icon: Icon(Icons.smartphone)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200]
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Stack(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.orange
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                    left: 5,
                                    child: Icon(
                                      Icons.bolt,
                                      color: Colors.white,
                                      size: 35,))
          
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          
                              children: [
                                SizedBox(height: 13,),
                                Text(
                                  "Monthly Electrical Energy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),),
                                Expanded(child: Text("17674.00 kWh"))
                              ],
                            )
          
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200]
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Stack(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blue
                                  ),
                                ),
                                Positioned(
                                    top: 3,
                                    left: 5,
                                    child: Icon(
                                      Icons.water_drop,
                                      color: Colors.white,
                                      size: 35,))
          
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          
                              children: [
                                SizedBox(height: 13,),
                                Text(
                                  "Monthly Water Consumption",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                Expanded(child: Text("--- m3"))
                              ],
                            ),
          
          
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200]
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Stack(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.red
                                  ),
                                ),
                                Positioned(
                                    top: 3,
                                    left: 6,
                                    child: Icon(
                                      Icons.local_gas_station,
                                      color: Colors.white,
                                      size: 35,))
          
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          
                              children: [
                                SizedBox(height: 13,),
                                Text(
                                  "Monthly Gas Consumption",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                Expanded(child: Text("185860.00 Nm3"))
                              ],
                            ),
          
          
                          ],
                        ),
                      )
          
          
                    ],
                  ),
                ),
          
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.history,size: 30,),
                              SizedBox(width: 10,),
                              Text(
                                  "Station Energy History",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          if (n>1)
                            AspectRatio(
                              aspectRatio: 2.0,
                              child: PieChart(
                                PieChartData(
                                  startDegreeOffset: 0,
                                  sectionsSpace: 0,
                                  sections: List.generate(n, (index) {
                                    final  integers = generateIntegersWithSum(n, sum);
                                    print(integers);
                                    return PieChartSectionData(
                                      color: randomColors[index],
                                      value: integers[index].toDouble(),
                                      title: '${integers[index]}%', // Display the integer value as the title
                                      radius: 90, // Adjust as needed
                                      titleStyle: TextStyle(color: Colors.white),
                                    );
                                  }),
                                  borderData: FlBorderData(show: false),
                                  centerSpaceRadius: 0,
                                ),
                                swapAnimationDuration: Duration(milliseconds: 800),
                                swapAnimationCurve: Curves.easeInOutBack,
                              ),
                            ),
                          if (n>1)
                            SizedBox(height: 20,),
                          if (n>1)
                            Container(
                              height: 180,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 15, // Adjust size as needed
                                            height: 15, // Adjust size as needed
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: randomColors[index],
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Text(filteredZones[index]["zone_name"])
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                    ],
                                  );
                                },
                                itemCount: n,

                              ),
                            ),

                          Container(
                            height: 270,
                            child: BarChart(

                              BarChartData(

                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false, // Set to false to hide vertical grid lines
                                ),
                                maxY: 2.5,
                                // Bar groups data
                                groupsSpace: 18,
                                barTouchData: BarTouchData(
                                  enabled: true, // Disable touch interaction
                                ),
                                titlesData: FlTitlesData(

                                  // Titles on x-axis and y-axis


                                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (double value, TitleMeta meta){
                                            int index = value.toInt();
                                            // Ensure the index is within the bounds of the bottomTitles list
                                            if (index < 0 || index >= bottomTitles.length) {
                                              return Text('');
                                            }
                                            return Text(bottomTitles[index].toString());
                                          }
                                      )
                                  ),
                                ),

                                borderData: FlBorderData(
                                  border: Border.all(color: Colors.black, width: 0),
                                ),
                                barGroups: barData
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




                        ],
                      ),
                      if(n>1)
                        Positioned(
                          top: 520,
                          left: -107,
                          child: Transform.rotate(
                            angle: -90 * 3.1415926535 / 180,
                            child: Text(
                              'Imported Energy (kWh) - May 2024',
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      else
                        Positioned(
                          top: 160,
                          left: -69,
                          child: Transform.rotate(
                            angle: -90 * 3.1415926535 / 180,
                            child: Text(
                              'Imported Energy (kWh)',
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                            ),
                          ),
                        )




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
