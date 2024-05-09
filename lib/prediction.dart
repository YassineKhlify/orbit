
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
    List<List<double>> data = List<List<double>>.from(json['i'].map((item) => List<double>.from(item)));




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
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(Icons.bolt,
                                    size: 31,),
                                  SizedBox(width: 3,),
                                  Text(
                                    'Courant :',
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
                                    barWidth: 4,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              )
                            )
                          ),
                        ],
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
