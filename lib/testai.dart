import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:orbit/prediction.dart';

class TimeSeriesPredictionPage extends StatefulWidget {
  @override
  _TimeSeriesPredictionPageState createState() =>
      _TimeSeriesPredictionPageState();
}

class _TimeSeriesPredictionPageState extends State<TimeSeriesPredictionPage> {
  String? selectedLocation;
  String beginDateText = "Enter Beginning date";
  String endDateText = "Enter End date";// example list, replace with your actual data
// example list, replace with your actual data
  DateTime selectedBeginDate1=DateTime.now();
  DateTime selectedEndDate2=DateTime.now();
  List<int> dayOfWeek = [];
  List<int> dayOfMonth = [];
  List<int> hourOfDay = [];
  List<int> minuteOfHour = [];
  List<int> month = [];
  List<int> isWeekend = [];

  var _prediction = 'Prediction will appear here';
  List<ValueItem> deviceTypeItems=[  ValueItem(label: 'Electric', value: 'electric')] ;
  List params = [];

  List<ValueItem> deviceItems=[  ValueItem(label: 'GENERAL A120', value: 'GENERAL A120')] ;
  List<ValueItem> usineItems=[  ValueItem(label: 'Sartex Bloc A 210 kVa', value: 'Sartex Bloc A 210 kVa')] ;
  List<ValueItem> stationItems=[  ValueItem(label: 'Sartex Bloc A 210 kVa', value: 'Sartex Bloc A 210 kVa')] ;
  List<ValueItem> zoneItems=[  ValueItem(label: 'Sources', value: 'Sources')] ;
  List<ValueItem> parameters=[
    ValueItem(label: 'Imported Energy', value: 'eit'),
    ValueItem(label: 'Current', value: 'i'),
    ValueItem(label: 'Power Factor', value: 'pft'),
    ValueItem(label: 'Active Power', value: 'pt'),
    ValueItem(label: 'Reactive Power', value: 'qt'),
    ValueItem(label: 'Apparent Power', value: 'st'),
    ValueItem(label: 'THDT', value: 'thdt')
  ] ;








  Future<void> _sendPredictionRequest() async {
    var url = Uri.parse('http://192.168.1.195:5000/predict');
    var data = jsonEncode({
      'parameter': params,
      'day_of_week': dayOfWeek,
      'hour_of_day': hourOfDay,
      'minute_of_hour': minuteOfHour,
      'month': month,
      'day_of_month': dayOfMonth,
      'is_weekend': isWeekend
      // Your time series data here
    });

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      setState(() {
        _prediction = responseData.toString();
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _controller;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              SizedBox(height: 30,),
              Row(
                children: [
                  Icon(Icons.online_prediction,
                    size: 32,),
                  SizedBox(width: 8,),
                  Text(
                    "Predict Future Consumption",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Adjust the font size as needed
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("This feature is only available to a limited number of devices",
              style: TextStyle(
                color: Colors.grey[600],

              ),),
              SizedBox(height: 10,),

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
                  setState(() {
          
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
                  params.clear();
                  for (var item in options) {
                    params.add(item.value);
                  }



                  print(options);
                  // Other logic related to option selection if needed
                },
                options:  parameters,
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
                  print(options);
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
                  print(options);
          
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
                  print(options);
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
                  print(options);
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
                  print(params);
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
                                        "Sampling Period is set to :1 Day.",
                                        textAlign: TextAlign.center,

                                        style: TextStyle(
                                          fontSize: 18,

                                            fontWeight: FontWeight.bold// Adjust the font size as needed
                                        ),
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
          
          
          
                                              print("selec");
                                              print(selectedDateTime);
                                              selectedBeginDate1=selectedDateTime;


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
                                              selectedEndDate2=selectedDateTime;
          
                                              // Format the combined date and time
          
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
                                            onPressed: ()  async {
                                              dayOfMonth.clear();
                                              dayOfWeek.clear();
                                              isWeekend.clear();
                                              hourOfDay.clear();
                                              minuteOfHour.clear();
                                              month.clear();
                                              print(selectedBeginDate1);
                                              print(selectedEndDate2);
                                              int numberOfSamples = (selectedEndDate2.difference(selectedBeginDate1).inDays) + 1;
                                              print(numberOfSamples);

                                              // Generate lists
                                              for (int i = 0; i < numberOfSamples; i++) {
                                                DateTime currentDateTime = selectedBeginDate1.add(Duration(days: i));

                                                dayOfWeek.add(currentDateTime.weekday);
                                                dayOfMonth.add(currentDateTime.day);
                                                hourOfDay.add(currentDateTime.hour);
                                                minuteOfHour.add(currentDateTime.minute);
                                                month.add(currentDateTime.month);
                                                isWeekend.add(currentDateTime.weekday == 6 || currentDateTime.weekday == 7 ? 1 : 0);
                                              }

                                              // Print the generated lists (for debugging)
                                              print('day_of_week: $dayOfWeek');
                                              print('day_of_month: $dayOfMonth');
                                              print('hour_of_day: $hourOfDay');
                                              print('minute_of_hour: $minuteOfHour');
                                              print('month: $month');
                                              print('is_weekend: $isWeekend');
                                              await _sendPredictionRequest();
                                              print(_prediction);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PredictionsPage(
                                                predictions: _prediction,
                                                params: params,
                                              )));



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

void main() {
  runApp(MaterialApp(
    title: 'Time Series Prediction',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: TimeSeriesPredictionPage(),
  ));
}
