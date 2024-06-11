
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:influxdb_client/api.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

class PredictionsPage extends StatefulWidget  {
  final String predictions;
  final List params;


  const PredictionsPage({Key? key, required this.predictions, required this.params}) : super(key: key);

  @override
  State<PredictionsPage> createState() => _PredictionsPageState();
}

class _PredictionsPageState extends State<PredictionsPage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    String predictions = widget.predictions;
    // Regular expression to match keys
    RegExp keyPattern = RegExp(r'([a-zA-Z0-9_]+):');

    // Replace keys with double quotes around them
    predictions = predictions.replaceAllMapped(keyPattern, (match) {
      return '"${match.group(1)}":';
    });
    print(predictions);
    Map<String, dynamic> json = jsonDecode(predictions);




    print(json["i"]);
    print("preds$predictions");
    print("params${widget.params}");

    TabController _tabController = TabController(length: 2, vsync: this);



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
                        Icon(Icons.online_prediction,
                          size: 32,),
                        SizedBox(width: 10,),
                        Text("Consumption Forecast",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
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
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.deepPurple,
                              ),
                              child: Text(
                                " ⦿ GENERAL A120",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
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
                        itemCount: widget.params.length,
                        itemBuilder: (context, index){
                          print(widget.params[index]);
                          List<ValueItem> electricalParameterItems = [
                            ValueItem(label: 'Imported Energy', value: 'eit'),
                            ValueItem(label: 'Current', value: 'i'),
                            ValueItem(label: 'Power Factor', value: 'pft'),
                            ValueItem(label: 'Active Power', value: 'pt'),
                            ValueItem(label: 'Reactive Power', value: 'qt'),
                            ValueItem(label: 'Apparent Power', value: 'st'),
                            ValueItem(label: 'THDT', value: 'thdt')
                          ];
                          // Find the corresponding ValueItem
                          ValueItem? selectedValueItem;
                          for (ValueItem item in electricalParameterItems) {
                            if (item.value == widget.params[index]) {
                              selectedValueItem = item;
                              break;
                            }
                          }
                          String parameterLabel = selectedValueItem != null ? selectedValueItem.label : 'Label not found';


                          List<List<double>> data = List<List<double>>.from(json[widget.params[index]].map((item) => List<double>.from(item)));

                          List<double> flattenedList = data.map((innerList) => innerList.first).toList();

                          double minValue = flattenedList.reduce((a, b) => a < b ? a : b);
                          double maxValue = flattenedList.reduce((a, b) => a > b ? a : b);
                          double avgValue = flattenedList.reduce((a, b) => a + b) / flattenedList.length;

                          return Column(
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
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: data.asMap().entries.map((entry) {
                                              return FlSpot(entry.key.toDouble(), entry.value.first);
                                            }).toList(),
                                            isCurved: true,
                                            color: Colors.blue,
                                            barWidth: 2,
                                            isStrokeCapRound: true,
                                            belowBarData: BarAreaData(show: false),
                                          ),
                                        ],
                                      )
                                  )
                              ),
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
                                          DataCell(Text(maxValue.toStringAsFixed(2))),
                                          DataCell(Text(minValue.toStringAsFixed(2))),
                                          DataCell(Text(avgValue.toStringAsFixed(2))),
                                        ])
                                      ],
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          );
                        },

                      ),

                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: widget.params.length,
                          itemBuilder: (context,index){

                          },
                      ),
                    )


                  ],

                ),
              ),
            ),


          ],
        )
    );
  }
}
