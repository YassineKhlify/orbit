
import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

class ChartsPage extends StatefulWidget  {
  final String receivedMessage;
  final String request;

  const ChartsPage({Key? key, required this.receivedMessage, required this.request}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> with TickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 2, vsync: this);
    // Parse the received JSON message
    final Map<String, dynamic> json = jsonDecode(widget.receivedMessage);
    final Map<String, dynamic> reqJson = jsonDecode(widget.request);
    List<String> deviceLabels = [];
    for (var device in reqJson['devices']) {
      deviceLabels.add(device['label']);
    }


    // Use the JSON data to display charts
    // Example: Create charts using the received JSON data
    final List<dynamic> data = json['data'];
    // Define initial minY and maxY values


    // Calculate additional padding for minY and maxY


    return Scaffold(

      body:  Column(
        children: [

          Padding(
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


                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
          Container(

            child:TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Graphics & Resume",
                  ),
                  Tab(
                    text: "History",
                  )

                ]
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              child: TabBarView(

                controller: _tabController,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        final Map<String, dynamic> parameterData = data[index];
                        final String parameterName = parameterData['parameter'];
                        List<ValueItem> electricalParameterItems = [
                          ValueItem(value: 'voltage',label: 'Voltages Ph-N'),
                          ValueItem(value: 'Voltages Ph-Ph',label: 'Voltages Ph-Ph'),
                          ValueItem(value: 'current',label: 'Courants'),
                          ValueItem(value: 'p_active',label: 'Active Power'),
                          ValueItem(value: 'p_active_LDC',label: 'Active Power Load Duration Curve (LDC)'),
                          ValueItem(value: 'p_reactive',label: 'Reactive Power'),
                          ValueItem(value: 'p_reactive_LDC',label: 'Reactive Power Load Duration Curve (LDC)'),
                          ValueItem(value: 'p_apparent',label: 'Apparent Power'),
                          ValueItem(value: 'p_apparent_LDC',label: 'Apparent Power Load Duration Curve (LDC)'),
                          ValueItem(value: 'fp',label: 'Power Factor'),
                          ValueItem(value: 'thdi',label: 'THDI'),
                          ValueItem(value: 'thdv',label: 'THDV'),
                        ];
                        // Find the corresponding ValueItem
                        ValueItem? selectedValueItem;
                        for (ValueItem item in electricalParameterItems) {
                          if (item.value == parameterName) {
                            selectedValueItem = item;
                            break;
                          }
                        }
                        String parameterLabel = selectedValueItem != null ? selectedValueItem.label : 'Label not found';


                        final List<dynamic> charts = parameterData['chart'];
                        double minY = double.infinity;
                        double maxY = -double.infinity;
                        List<String> subParameters = [];

                        List<LineChartBarData> lineBarsData = [];



                        // Iterate over each chart data to find minY and maxY values for the parameter
                        for (final chartData in charts) {
                          final List<dynamic> data = chartData['data'];
                          print("chart[$index]=${chartData['data']}");
                          print("param[$index]=${chartData['name']}");
                          String result = chartData['name'].split(" : ")[1];

                          print(result); // Output: Ia
                          subParameters.add(result); // Add 'result' to the subParameters list





                          for (final entry in data) {
                            final value = entry[1].toDouble();

                            if (value < minY) {
                              minY = value;
                            }

                            if (value > maxY) {
                              maxY = value;
                            }
                          }
                        }
                        print(subParameters);
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
                        List <Color> randomColors = generateRandomColors(subParameters.length);
                        print("random colors populated");
                        print(randomColors);
                        for (int index = 0; index < charts.length; index++) {
                          final chartData = charts[index];
                          final List<dynamic> data = chartData['data'];
                          final List<FlSpot> lineChartData = data.map((entry) => FlSpot(
                            data.indexOf(entry).toDouble(),
                            entry[1].toDouble(), // Assuming entry is a List<dynamic> with [timestamp, value]
                          )).toList();
                          print("indddddddddddddd$index");
                          print("rrrrrrrrrrrrrrr$randomColors");
                          lineBarsData.add(
                            LineChartBarData(
                              spots: lineChartData,
                              isCurved: true,
                              color: randomColors[index], // Assign a color from the list
                              barWidth: 2,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(show: false),
                            ),
                          );
                        }



                        // Calculate additional padding for minY and maxY
                        final double padding = (maxY - minY) * 0.1;
                        return Column(
                          crossAxisAlignment:  CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(Icons.bolt,
                                  size: 31,),
                                  SizedBox(width: 3,),
                                  Text(
                                    '$parameterLabel :',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 20,),
                                ],
                              )
                            ),
                            Container(
                              height: 300,
                              padding: const EdgeInsets.all(8.0),
                              child: LineChart(
                                LineChartData(

                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(color: Colors.black, width: 1),
                                  ),
                                  minX: 0,
                                  maxX: charts[0]['data'].length.toDouble() - 1,
                                  minY: minY - padding,
                                  maxY: maxY + padding,
                                  lineBarsData: lineBarsData

                                ),

                              ),
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: subParameters.length,
                                itemBuilder: (context, index){
                                  return SizedBox(
                                    height: 20,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 150,),
                                        Column(
                                          children: [
                                            (
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: randomColors[index]
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Text(subParameters[index])
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(height: 10,),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 11.0), // Adjust the horizontal padding
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey
                                      )
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(

                                    columnSpacing: 45, // Adjust the spacing between columns
                                    dataRowHeight: 35, // Adjust the height of each row
                                    columns: [
                                      DataColumn(label: Text("Max Value",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),)),
                                      DataColumn(label: Text("Min Value",style: TextStyle(
                                        fontSize: 13,
                                      ),)),
                                      DataColumn(label: Text("Avg Value",style: TextStyle(
                                        fontSize: 13,
                                      ),)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text("dash")),
                                        DataCell(Text("dash")),
                                        DataCell(Text("dash")),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),
                          ],
                        );
                      },
                    ),
                  ),
                  Text("data")


                ],

              ),
            ),
          ),


        ],
      )
    );
  }
}
