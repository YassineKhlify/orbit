import 'dart:convert';
import 'dart:developer' as developer;



import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';

import 'charts_page.dart';


class AnalyticsPage extends StatefulWidget {
  final String id;
  AnalyticsPage({required this.id});
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class MyData {
  String requestType;
  List<Map<String, String>> devices;
  String dateDebut;
  String dateFin;
  List<String> parameters;
  String echantillonnage;
  String timePost;

  MyData({
    required this.requestType,
    required this.devices,
    required this.dateDebut,
    required this.dateFin,
    required this.parameters,
    required this.echantillonnage,
    required this.timePost,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestType': requestType,
      'devices': devices,
      'date_debut': dateDebut,
      'date_fin': dateFin,
      'parameters': parameters,
      'echantillonnage': echantillonnage,
      'time_post': timePost,
    };
  }
}
class _AnalyticsPageState extends State<AnalyticsPage> {
  late String receivedMessage;

  List<String> usines = [];
  List<String> usinesId = [];
  List<String> stations = [];
  List<String> zones = [];
  List<String> devices = [];
  List<ValueItem> adequateParameters = [];
  List<ValueItem> parameterOptions = []; // Define options as an empty list initially
// Define options as an empty list initially





  List<String> adequateStations = [];
  List<String> adequateZones = [];
  List<String> adequateDevices = [];





  late WebSocketChannel channel;

  @override
  bool isLoading = true;

  String? selectedLocation;

  List<String> deviceTypes = ['Electric', 'Temperature & Humidity', 'Automates', 'Calculated Variables'];
  List<String> electricalParameterTypes = ['Electric', 'Temperature & Humidity', 'Automates', 'Calculated Variables']; // example list, replace with your actual data
// example list, replace with your actual data
  String beginDateText = "Enter Beginning date";
  String endDateText = "Enter End date";// example list, replace with your actual data
// example list, replace with your actual data
  DateTime selectedBeginDate1=DateTime.now();
  DateTime selectedEndDate2=DateTime.now();
  String formattedDateTime1='';
  String formattedDateTime2='';


  String selectedBeginDate = "";

  String selectedEndDate = "";

  List<ValueItem> usineItems=[];
  List<ValueItem> usineOptions=[];



  List<ValueItem> stationItems=[];
  List<ValueItem> stationOptions=[];

  List<dynamic>? receivedStations ;

  List<ValueItem> zoneItems=[];
  List<ValueItem> zoneOptions=[];

  List<dynamic>? receivedZones ;

  List<ValueItem> deviceItems=[];
  List<ValueItem> deviceOptions=[];

  List<dynamic>? receivedDevices ;
  List<dynamic>? selectedDevicesList=[] ;

  void sendDataViaWebSocket() {

    // Convert the data to JSON

    var url1 = Uri.parse('wss://orbitsmart.energy/ws');

    // Create a WebSocket channel
    var channel1 = IOWebSocketChannel.connect(url1);
    // Define variables for JSON fields
    String requestType = 'history_multiple';
    List<Map<String, String>> transformedDevices = [];

// Iterate over selectedDevicesList and transform each device
    for (var device in selectedDevicesList!) {
      transformedDevices.add({
        'label': device['device_name'].toString(),
        'value': device['_id'].toString(),
        'type': device['device_type'].toString(),
        // Add other fields if needed
      });
    }
    List<Map<String, String>> devices = transformedDevices;
    String dateDebut = formattedDateTime1;

    String dateFin = formattedDateTime2;

    List<String> parameters = [];
    for (var item in parameterOptions) {
      if(item.value != null){
        parameters.add(item.value!);

      }
    }
    String echantillonnage = selectedLocation!;
    String timePost = '';

    // Create an instance of MyData using variables
    MyData myData = MyData(
      requestType: requestType,
      devices: devices,
      dateDebut: dateDebut,
      dateFin: dateFin,
      parameters: parameters,
      echantillonnage: echantillonnage,
      timePost: timePost,
    );

    // Convert the instance to JSON
    String jsonStr = jsonEncode(myData.toJson());

    // Send JSON data via WebSocket
    try {
      // Send JSON data via WebSocket
       channel1.sink.add(jsonStr);
      // Data has been successfully sent
      print('Data sent successfully');
    } catch (error) {
      // Handle error if data sending fails
      print('Error sending data: $error');
    } finally {
      // Close the WebSocket connection after sending data
    }

    // Listen for incoming messages (optional)



// Inside your function where you listen for received messages
    channel1.stream.listen((message) {
      setState(() {
        receivedMessage = message;
      });
      developer.log('Received message: $message');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChartsPage(receivedMessage: receivedMessage, request: jsonStr,),
        ),
      );
    });






    // Now you can send `jsonStr` via WebSocket
    print(jsonStr);
    // Add your WebSocket logic here to send the JSON data
  }




  void initState() {
    super.initState();
    _connectToWebSocket();

  }
  void _connectToWebSocket() {
    final String superUserId = widget.id;
    channel = IOWebSocketChannel.connect(
        'wss://orbitsmart.energy/Mongo/get_analyse_devices_by_user_id');

    // Sending the super user id when socket is opened
    channel.sink.add('{"super_user_id": "$superUserId"}');

    // Listening for incoming messages
    channel.stream.listen(
            (message) {
          // Parse the message as JSON
          Map<String, dynamic>? parsedMessage = json.decode(message);

          if (parsedMessage != null) {
            // Access individual properties
            String? alerte = parsedMessage['alerte'];
            Map<String, dynamic>? data = parsedMessage['data'];

            if (alerte != null && data != null) {
              print("Received data from WebSocket:");
              print("Alerte: $alerte");

              // Print devices




              if (usines != null) {
                List<dynamic>? receivedUsines = data['usine'];
                isLoading=false;

                if (receivedUsines != null) {
                  setState(() {
                    usinesId.addAll(receivedUsines.map((usine) => usine['_id'].toString()));
                    print(usinesId);
                    usines.clear();
                    usines.addAll(receivedUsines.map((usine) => usine['usine_name'].toString()));

                    usineItems = receivedUsines.map((usine) =>
                        ValueItem(label: usine['usine_name'].toString(), value: usine['_id'].toString()))
                        .toList();

                  });
                }
              }

              if (stations != null) {
                 receivedStations = data['station'];
                isLoading=false;
              }

              if (zones != null) {
                receivedZones = data['zones'];
                isLoading=false;
              }

              if (devices != null) {
                 receivedDevices = data['devices'];
                isLoading=false;
              }






              // Print other data properties...
            } else {
              print("Received message does not contain expected fields.");
            }
          } else {
            print("Received message is not valid JSON.");
          }
        },

        onError: (error) {
          print("Error occurred: $error");
          // Reconnect if an error occurs
          _connectToWebSocket();
          isLoading=false;

        }, onDone: () {
      print("WebSocket connection closed");
      isLoading=false;

      // Reconnect when connection is closed
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {









    List<ValueItem> deviceTypeItems = deviceTypes.map((type) => ValueItem(label: type, value: type)).toList();
    List<ValueItem> deviceTypeOptions=[] ;

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





    var _controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analytics",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18, // Adjust the font size as needed
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child:SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Row(
                children: [
                  Icon(Icons.settings,
                    size: 30,),
                  SizedBox(width: 8,),
                  Text(
                    "Configuration",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Adjust the font size as needed
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text(
                "Select Device Type:",
                style: TextStyle(
                  fontSize: 15, // Adjust the font size as needed
                ),
              ),
              SizedBox(height: 5,),
              MultiSelectDropDown(
                showClearIcon: true,
                controller: _controller,
                onOptionSelected: (options) {
                  deviceTypeOptions= options;
                  print(deviceTypeOptions);
                  setState(() {
                    if (deviceTypeOptions.any((item) => item.value == 'Electric')) {
                      print('ahawma');
                      adequateParameters = electricalParameterItems;

                      print(adequateParameters);
                    } else {
                      adequateParameters = [ValueItem(label: 'Option ', value: '2')]; // or some other default value if needed
                    }
                  });
                },
                options:  deviceTypeItems,
                disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),

              SizedBox(height: 10,),
              Text(
                "Select Usines:",
                style: TextStyle(
                  fontSize: 15, // Adjust the font size as needed
                ),
              ),
              SizedBox(height: 5,),

              MultiSelectDropDown(
                showClearIcon: true,
                controller: _controller,
                onOptionSelected: (options) {
                  usineOptions = options;
                  print("usineoptions:");
                  print(usineOptions);
                  if (receivedStations != null) {
                    setState(() {
                      stations.clear();
                      Iterable? filteredStations = receivedStations?.where((station) =>
                          usineOptions.any((usine) => usine.value == station['usine_id'].toString()));
                      adequateStations.clear(); // Clear existing adequate stations


                      adequateStations.addAll(filteredStations!.map((station) => station['station_name'].toString()));
                      stationItems = filteredStations!.map((station) =>
                          ValueItem(label: station['station_name'].toString(), value: station['_id'].toString()))
                          .toList();
                    });
                  }

                },
                options: usineItems,
                disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              SizedBox(height: 10,),

              Text(
                "Select Stations:",
                style: TextStyle(
                  fontSize: 15, // Adjust the font size as needed
                ),
              ),
              SizedBox(height: 5,),
               MultiSelectDropDown(
                showClearIcon: true,
                controller: _controller,
                onOptionSelected: (options) {
                  stationOptions = options;
                  print("station options:");
                  print(stationOptions);
                  if (receivedZones != null) {
                    setState(() {
                      zones.clear();
                      Iterable? filteredZones = receivedZones?.where((zone) =>
                          stationOptions.any((station) => station.value == zone['station_id'].toString()));
                      adequateZones.clear();
                      print(zones);// Clear existing adequate stations


                      adequateZones.addAll(filteredZones!.map((zone) => zone['zone_name'].toString()));
                      zoneItems = filteredZones!.map((zone) =>
                          ValueItem(label: zone['zone_name'].toString(), value: zone['_id'].toString()))
                          .toList();
                    });
                  }

                },
                options: stationItems,
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),




              SizedBox(height: 10,),
              Text(
                "Select Zones:",
                style: TextStyle(
                  fontSize: 15, // Adjust the font size as needed
                ),
              ),
              SizedBox(height: 5,),
              MultiSelectDropDown(
                showClearIcon: true,
                controller: _controller,
                onOptionSelected: (options) {
                  zoneOptions = options;
                  print("zone options:");
                  print(zoneOptions);
                  print(receivedDevices);

                  if (receivedDevices != null) {
                    print(receivedDevices);
                    setState(() {
                      devices.clear();
                      Iterable? filteredDevices = receivedDevices?.where((device) =>
                          zoneOptions.any((zone) => zone.value == device['zone_id'].toString()));
                      adequateDevices.clear();

                      print("devices");
                      print(devices);// Clear existing adequate stations


                      adequateDevices.addAll(filteredDevices!.map((device) => device['device_name'].toString()));
                      deviceItems = filteredDevices!.map((device) =>
                          ValueItem(label: device['device_name'].toString(), value: device['_id'].toString()))
                          .toList();
                    });
                  }

                },
                options: zoneItems,
                disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              SizedBox(height: 10,),

              Text(
                "Select Devices:",
                style: TextStyle(
                  fontSize: 15, // Adjust the font size as needed
                ),
              ),
              SizedBox(height: 5,),
              MultiSelectDropDown(
                showClearIcon: true,
                controller: _controller,
                onOptionSelected: (options) {
                  deviceOptions = options;
                  selectedDevicesList ??= [];

                  // Populating selectedDevicesList based on condition
                  // Ensure that selectedDevicesList is not null

                  // Clear selectedDevicesList before repopulating it
                  selectedDevicesList!.clear();

                  // Populating selectedDevicesList based on condition
                  if (receivedDevices != null) {
                    for (var device in receivedDevices!) {
                      if (deviceOptions.any((option) => option.value == device['_id'].toString())) {
                        selectedDevicesList!.add(device);
                      }
                    }
                  }
                  print("here: $selectedDevicesList");
                },
                options: deviceItems,
                disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              SizedBox(height: 10,),
              Text(
                "Select Parameters to Show:",
                style: TextStyle(
                  fontSize: 15, // Adjust the font size as needed
                ),
              ),
              SizedBox(height: 5,),
              MultiSelectDropDown(
                showClearIcon: true,
                controller: _controller,
                onOptionSelected: (options) {
                  parameterOptions = options;
                  print(options);
                  // Other logic related to option selection if needed
                },
                options:  adequateParameters,
                disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),


              SizedBox(height: 10,),



              Text(""),

              FilledButton.icon(
                icon: Icon(Icons.arrow_circle_right),
                label:Text('Next') ,
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  minimumSize: Size(double.infinity, 0), // Set width to span horizontally

                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                  ),
                ),


                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState){
                              return Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                  width: double.infinity,
                                  // Set width to span entire screen

                                  height: 310,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Select Sampling Period:",
                                        style: TextStyle(
                                          fontSize: 15, // Adjust the font size as needed
                                        ),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: selectedLocation,
                                        items: [
                                          '1min',
                                          '5min',
                                          '10min',
                                          '15min',
                                          '30min',
                                          '1h',
                                          '1d',
                                          '1w',
                                          '1mo'
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedLocation = value!; // Store selected value
                                          });
                                          print('Selected location: $selectedLocation');
                                        },
                                      ),
                                      SizedBox(height: 15,),
                                      Text(
                                        "Select Begin Date:",
                                        style: TextStyle(
                                          fontSize: 15, // Adjust the font size as needed
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          // Show date picker
                                          final DateTime? selectedDate = await showDatePicker(
                                            context: context,
                                            initialDate: selectedBeginDate1,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(3000),
                                          );

                                          if (selectedDate != null) {
                                            // Show time picker
                                            final TimeOfDay? selectedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );

                                            if (selectedTime != null) {
                                              // Combine date and time
                                              DateTime selectedDateTime = DateTime(
                                                selectedDate.year,
                                                selectedDate.month,
                                                selectedDate.day,
                                                selectedTime.hour,
                                                selectedTime.minute,
                                              );

                                              // Format the combined date and time
                                              formattedDateTime1 = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(selectedDateTime.toUtc());
                                              formattedDateTime1 += 'Z';


                                              print("selec");
                                              print(selectedDateTime);
                                              print(formattedDateTime1);

                                              setState(() {
                                                beginDateText = "${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year} ${selectedTime.format(context)}"; // Display date and time in your desired format
                                              });
                                            }
                                          }
                                        },

                                        icon: Icon(Icons.date_range), // Icon
                                        label: Text('$beginDateText'), // Text
                                        style: ElevatedButton.styleFrom(
                                          elevation: 3,
                                          minimumSize: Size(double.infinity, 0), // Set width to span horizontally

                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                      Text(
                                        "Select End Date:",
                                        style: TextStyle(
                                          fontSize: 15, // Adjust the font size as needed
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          // Show date picker
                                          final DateTime? selectedDate = await showDatePicker(
                                            context: context,
                                            initialDate: selectedEndDate2,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(3000),
                                          );

                                          if (selectedDate != null) {
                                            // Show time picker
                                            final TimeOfDay? selectedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );

                                            if (selectedTime != null) {
                                              // Combine date and time
                                              DateTime selectedDateTime = DateTime(
                                                selectedDate.year,
                                                selectedDate.month,
                                                selectedDate.day,
                                                selectedTime.hour,
                                                selectedTime.minute,
                                              );

                                              // Format the combined date and time
                                              formattedDateTime2 = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(selectedDateTime.toUtc());
                                              formattedDateTime2 += 'Z';


                                              setState(() {
                                                endDateText = "${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year} ${selectedTime.format(context)}"; // Display date and time in your desired format
                                              });
                                            }
                                          }
                                        },

                                        icon: Icon(Icons.date_range), // Icon
                                        label: Text('$endDateText'),
// Text
                                        style: ElevatedButton.styleFrom(
                                          elevation: 3,
                                          minimumSize: Size(double.infinity, 0), // Set width to span horizontally

                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 13,),
                                      Row(
                                        children: [
                                          SizedBox(width: 200,),
                                          FilledButton.icon(
                                            onPressed: (){
                                              sendDataViaWebSocket();


                                            },
                                            icon: Icon(Icons.send),
                                            label: Text("Submit"),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 3,

                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
                                              ),
                                            ),


                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              );

                            });


                      });
                  // Handle submit action
                  // You can access selectedDeviceType, selectedUsine, selectedStation, selectedZone, and selectedDate here
                },

              ),
            ],
          ),
        ),
      ),
    );
  }


}



