import 'package:flutter/material.dart';

class AddDevicePage extends StatefulWidget {
  final List<String> zoneNames;

  AddDevicePage({required this.zoneNames});
  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  String? selectedDeviceType;

  late TextEditingController _zoneNameController;
  void initState() {
    super.initState();
    _zoneNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 45,),

            Row(
              children: [
                Icon(Icons.smartphone,
                  size: 33,),
                SizedBox(width: 10,),
                Text("Add New Device",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),)
              ],
            ),
            SizedBox(height: 45,),
            Expanded(
              child: SingleChildScrollView(
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
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black54,
                        )
                      ),
                      child: DropdownButtonFormField<String>(
                        hint: Text("Select Device Type"),
                        value: selectedDeviceType,
                        items: [
                          'Electrical meter',
                          'Temperature meter',
                          'Automate',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDeviceType = value!; // Store selected value
                          });
                          print('Selected location: $selectedDeviceType');
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Enter Device Constructor',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Enter Device Model',
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black54,
                          )
                      ),
                      child: DropdownButtonFormField<String>(
                        hint: Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 10,),
                            Text("Select Zone"),
                          ],
                        ),
                        value: selectedDeviceType,
                        items: widget.zoneNames.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 10,),
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDeviceType = value!; // Store selected value
                          });
                          print('Selected location: $selectedDeviceType');
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
              
              
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Enter Device Name',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.device_hub), // Icon you want to display
              
              
              
                        labelText: 'Hiererachical Index',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Parent',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.laptop), // Icon you want to display
              
              
                        labelText: 'IP Adress',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Port',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Id',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Gateway Type',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _zoneNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
              
              
                        labelText: 'Gateway Id',
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                elevation: 3,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                ),
                              ),

                              label: Text("Add Device"),
                              icon: Icon(Icons.add)
                          ),
                        ),
                      ],
                    )
              
              
              
              
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
