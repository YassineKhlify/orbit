import 'package:flutter/material.dart';

class EditDevice extends StatefulWidget {
  final Map<String, dynamic> myDevice;
  EditDevice({required this.myDevice});

  @override
  State<EditDevice> createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  late TextEditingController _zoneNameController;
  void initState() {
    super.initState();
    _zoneNameController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var myDevice = widget.myDevice;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.edit),
            SizedBox(width: 5,),
            Text("Edit ${myDevice['device_name']}",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),)
          ],
        ),
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Edit Device Name"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.smartphone),
                      SizedBox(width: 5,),
                      Text(myDevice['device_name']),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.smartphone), // Icon you want to display


                              labelText: 'Enter Device Name',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Edit Device Model"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(myDevice['device_model']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),


                              labelText: 'Enter Device Model',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Edit Device Constructor"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(myDevice['device_constructor']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),


                              labelText: 'Enter Device Constructor',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Edit Hierarchical Index"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.device_hub),
                      SizedBox(width: 5,),
                      Text(myDevice['device_index']),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.device_hub), // Icon you want to display


                              labelText: 'Enter Hierarchical Index',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Text("Edit IP adress"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.laptop),
                      SizedBox(width: 5,),
                      Text(myDevice['device_ip']),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.laptop), // Icon you want to display


                              labelText: 'Enter IP Adress',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Edit Device Port"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(myDevice['device_port']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),


                              labelText: 'Enter Device Port',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Edit Device Id"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(myDevice['_id']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),


                              labelText: 'Enter Device Id',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Edit Gateway Type"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(myDevice['gateway_type']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),


                              labelText: 'Enter Gateway Type',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Edit Gateway Id"),
              SizedBox(height: 5,),
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(myDevice['gateway_id']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _zoneNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),


                              labelText: 'Enter Gateway Id',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(children: [
                            SizedBox(width: 205,),
                            FilledButton.icon(
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),
                              label: Text("Save"),
                              icon: Icon(Icons.edit),)
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
