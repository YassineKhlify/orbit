import 'package:flutter/material.dart';
import 'login_page.dart';
import 'notification_listener.dart' as MyNotification;
// Import the NotificationListener class with a prefix
import 'dart:io' show Platform;
import 'package:influxdb_client/api.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();

 // Ensure that WidgetsFlutterBinding is initialized

// You can generate an API token from the "API Tokens Tab" in the UI
  var token = 'YCH5PZSPb_bMJpJWzipRVq5lrxMpYM41E-Ne8CFrl2wONSdC-89HtNMwBBHExWTPo1C9kJoML7XXmnisgfV0YQ==';
  var bucket = 'mydatabase';
  var org = 'orbitpfe';

  var client = InfluxDBClient(
      url: 'http://192.168.115.24:8086',
      token: token,
      org: org,
      bucket: bucket);
  var point = Point('h2o')
      .addTag('location', 'Prague')
      .addField('level', 1.12345)
      .time(DateTime.now().toUtc());

  var writeService = client.getWriteService();
  //await writeService.write(point).then((value) {
  //  print('Write completed');
  //}).catchError((exception) {
  //  print("erreuuur");
  //  print(exception);
  //});
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  final MyNotification.NotificationListener _notificationListener = MyNotification.NotificationListener();


  @override
  Widget build(BuildContext context) {
    //_notificationListener.startListening();

    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
