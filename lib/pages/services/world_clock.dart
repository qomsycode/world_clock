import 'package:flutter/material.dart'; // Add this line to fix the error
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldClock {
  String location;
  late String time; // 'late' tells Dart we will set this in getTime
  String flag;
  String url;

  // Added 'required' to fix the parameter errors
  WorldClock({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // 1. Fetch data from timeapi.io
      http.Response response = await http
          .get(Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'))
          .timeout(const Duration(seconds: 10));

      Map data = jsonDecode(response.body);

      // 2. Extract the time directly from the 'time' field
      // The API returns time in 'HH:mm' format
      String rawTime = data['time']; // e.g., "22:09"
      
      // 3. Convert to formatted time (e.g., 10:09 PM)
      // Since timeapi.io already accounts for offset, we just need to format it
      DateTime now = DateTime.parse(data['dateTime']);
      time = DateFormat.jm().format(now);

      debugPrint('Full Data: $data');
      debugPrint('The Time is: $time');

    } catch (e) {
      debugPrint('caught error: $e');
      time = 'Retry connection';
    }
  }
}
