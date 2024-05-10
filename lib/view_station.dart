import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ViewStationPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> stationData;

  ViewStationPage({required this.stationData,required this.data});

  @override
  State<ViewStationPage> createState() => _ViewStationPageState();
}

class _ViewStationPageState extends State<ViewStationPage> {


  @override
  Widget build(BuildContext context) {
    final userData = widget.data;
    final zonesData = userData['zones'];

    // Initialize a list to store filtered stations
    List<dynamic> filteredZones = [];

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
      print("Zone Name: ${zone['zone_name']}, Usine ID: ${zone['station_id']}");
    });
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

    List<PieChartSectionData> sections = List.generate(n, (index) {
     final  integers = generateIntegersWithSum(n, sum);
     print(integers);
      return PieChartSectionData(
        color: randomColors[index],
        value: integers[index].toDouble(),
        title: '${integers[index]}%', // Display the integer value as the title
        radius: 90, // Adjust as needed
        titleStyle: TextStyle(color: Colors.white),
      );
    });
    final List<double> barData = [8,10,1,5, 8, 10, 12, 6];



    // Iterate over station data
    return Scaffold(
      appBar: AppBar(
        title: Text('Station : ${widget.stationData["station_name"]}',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18, // Adjust the font size as needed
        ),),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.smartphone))
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
                                Expanded(child: Text("0.000 kWh"))
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
                  child: Column(
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
                              sections: sections,
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
                ),
          
              ),
              Text('This is a blank View Station page.'),
            ],
          ),
        ),
      ),
    );
  }
}
