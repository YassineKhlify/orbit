// notification_listener.dart
import 'dart:convert';
import 'dart:async'; // Add this import
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NotificationListener {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<Map<String, dynamic>> _previousData = [];

  NotificationListener() {
    // Initialize the plugin
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void startListening() {
    print("heyyy nots");
    showNotification("Moteur Pates", "Electrique Pates", "Power Factor", -0.99);
    Timer.periodic(Duration(seconds: 1), (timer) {
      fetchData();
    });
  }
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://orbitsmart.energy/notification/settings/active/6506dfa5aa3237acf9bd8c7e'));
    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> newData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      final List<Map<String, dynamic>> newNotifications = findNewNotifications(newData);
      handleNewNotifications(newNotifications);
      _previousData = newData;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List<Map<String, dynamic>> findNewNotifications(List<Map<String, dynamic>> newData) {
    final List<Map<String, dynamic>> newNotifications = [];
    for (final notification in newData) {
      if (!_previousData.any((prevNotification) => _areEqualNotifications(notification, prevNotification))) {
        newNotifications.add(notification);
      }
    }
    return newNotifications;
  }

  bool _areEqualNotifications(Map<String, dynamic> notification1, Map<String, dynamic> notification2) {
    // Compare notifications based on their unique identifier or any other criteria that makes them distinct
    // Here, I'm assuming 'device_id' uniquely identifies a notification
    return notification1['notification']['device_id'] == notification2['notification']['device_id'];
  }

  void handleNewNotifications(List<Map<String, dynamic>> newNotifications) {
    for (final notification in newNotifications) {
      final deviceName = notification['device']['device_name'];
      final zoneName = notification['zone']['zone_name'];
      final parameter = notification['notification']['parameter'];
      final value = notification['notification']['value'];
      // Show notification details
      showNotification(deviceName, zoneName, parameter, value);
    }
  }
  Future<void> showNotification(String deviceName, String zoneName, String parameter, double value) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('channel_id',
      'Channel Name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Notification',
      '$deviceName in $zoneName - $parameter: $value',
      platformChannelSpecifics,
      payload: 'notification',
    );
  }
}
