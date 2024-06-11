import 'package:flutter/material.dart';
import 'package:orbit/edit_device.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class ViewDevice extends StatefulWidget {
  final Map<String, dynamic> myDevice;
  ViewDevice({required this.myDevice});


  @override
  State<ViewDevice> createState() => _ViewDeviceState();
}

class _ViewDeviceState extends State<ViewDevice> {
  @override
  Widget build(BuildContext context) {
    var myDevice = widget.myDevice;

    return Scaffold(
      appBar: AppBar(
        
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FilledButton.icon(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditDevice(
                  myDevice: myDevice,
                )));

              },
              style: ElevatedButton.styleFrom(
                elevation: 3,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                ),
              ),

              label: Text("Edit Device"),
              icon: Icon(Icons.edit),),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.smartphone,size: 30,),
                    SizedBox(width: 5,),
                    Text(
                        myDevice['device_name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.bolt),
                      SizedBox(width: 5,),
                      Text("Active Power")
                    ],
                  ),
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(minimum: 0, maximum: 50,
                                ranges: <GaugeRange>[
                                  GaugeRange(startValue: 0, endValue: 500/3, color:Colors.green),
                                  GaugeRange(startValue: 500/3,endValue: 1000/3,color: Colors.orange),
                                  GaugeRange(startValue: 1000/3,endValue: 1500/3,color: Colors.red)],
                                pointers: <GaugePointer>[
                                  NeedlePointer(value: 458.30)],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(widget: Container(child:
                                  Text("458.30 kW",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                                      angle: 90, positionFactor: 0.5
                                  )]
                            )]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Pa",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("83.20",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kWh",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Pb",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("128.12",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kWh",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Pc",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("113.24",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kWh",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            )


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.bolt),
                      SizedBox(width: 5,),
                      Text("Reactive Power")
                    ],
                  ),
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(minimum: 0, maximum: 50,
                                ranges: <GaugeRange>[
                                  GaugeRange(startValue: 0, endValue: 50/3, color:Colors.green),
                                  GaugeRange(startValue: 50/3,endValue: 100/3,color: Colors.orange),
                                  GaugeRange(startValue: 100/3,endValue: 150/3,color: Colors.red)],
                                pointers: <GaugePointer>[
                                  NeedlePointer(value: 50)],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(widget: Container(child:
                                  Text("50 kVAr",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                                      angle: 90, positionFactor: 0.5
                                  )]
                            )]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Qa",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kVAr",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Qb",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kVAr",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Qc",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kVAr",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            )


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10,),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.bolt),
                      SizedBox(width: 5,),
                      Text("Apparent Power")
                    ],
                  ),
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(minimum: 0, maximum: 50,
                                ranges: <GaugeRange>[
                                  GaugeRange(startValue: 0, endValue: 50/3, color:Colors.green),
                                  GaugeRange(startValue: 50/3,endValue: 100/3,color: Colors.orange),
                                  GaugeRange(startValue: 100/3,endValue: 150/3,color: Colors.red)],
                                pointers: <GaugePointer>[
                                  NeedlePointer(value: 50)],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(widget: Container(child:
                                  Text("50 kVA",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                                      angle: 90, positionFactor: 0.5
                                  )]
                            )]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Sa",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kVA",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Sb",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kVA",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Sc",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("kVA",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            )


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10,),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.bolt),
                      SizedBox(width: 5,),
                      Text("Power Factor")
                    ],
                  ),
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(minimum: 0, maximum: 50,
                                ranges: <GaugeRange>[
                                  GaugeRange(startValue: 0, endValue: 50/3, color:Colors.green),
                                  GaugeRange(startValue: 50/3,endValue: 100/3,color: Colors.orange),
                                  GaugeRange(startValue: 100/3,endValue: 150/3,color: Colors.red)],
                                pointers: <GaugePointer>[
                                  NeedlePointer(value: 50)],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(widget: Container(child:
                                  Text("50 ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                                      angle: 90, positionFactor: 0.5
                                  )]
                            )]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("FPa",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("FPb",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("FPc",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),

                              ],
                            )


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.bolt),
                      SizedBox(width: 5,),
                      Text("Voltage (V)")
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Ua",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("V",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Ub",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("V",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Uc",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("V",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            )


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Uab",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("V",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Ubc",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("V",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Uca",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("V",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            )


                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),


              SizedBox(height: 10,),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.bolt),
                      SizedBox(width: 5,),
                      Text("Current (A)")
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Ia",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("A",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Ib",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("A",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Ic",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 70,),
                                Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 60,),
                                Text("A",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            )


                          ],
                        ),
                      ),
                    ),
                  ],

                ),
              ),
              SizedBox(height: 10,),
              Card(
                  elevation: 4,
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.bolt),
                        SizedBox(width: 5,),
                        Text("Total Harmonic")
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green
                                    ),
                                  ),
                                  Positioned(
                                    top:28,
                                      left: 9,
                                      child: Text(
                                          "THDV",
                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),)
                                  )
                                ],
                              ),
                              SizedBox(width: 10,),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("THDVa",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 70,),
                                      Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 60,),
                                      Text("%",style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text("THDVb",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 70,),
                                      Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 60,),
                                      Text("%",style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text("THDVc",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 70,),
                                      Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 60,),
                                      Text("%",style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  )


                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue
                                    ),
                                  ),
                                  Positioned(
                                      top:28,
                                      left: 12,
                                      child: Text(
                                        "THDI",
                                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),)
                                  )
                                ],
                              ),
                              SizedBox(width: 10,),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("THDIa",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 70,),
                                      Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 60,),
                                      Text("%",style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text("THDIb",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 70,),
                                      Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 60,),
                                      Text("%",style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text("THDIc",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 70,),
                                      Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 60,),
                                      Text("%",style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  )


                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: 10,),
              Card(
                  elevation: 4,
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.bolt),
                        SizedBox(width: 5,),
                        Text("Import Active Energy")
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("1364512.00 kWh",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                fontSize: 20
                              ),),
                              Text("Annual Consumption",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                              ),),



                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("225016.00 kWh",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20
                              ),),
                              Text("Monthly Consumption",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                              ),),



                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),

            ],
          ),
        ),
      )
    );
  }
}
