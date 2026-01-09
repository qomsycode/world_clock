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
      http.Response response = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'))
          .timeout(const Duration(seconds: 10));

      Map data = jsonDecode(response.body);

      // 1. Get the initial UTC time
      String datetime = data['datetime'];
      String offset = data['utc_offset']; // e.g., "-05:00"

      DateTime now = DateTime.parse(datetime);

      // 2. Extract the hours from the offset string (position 1 to 3)
      int offsetHours = int.parse(offset.substring(1, 3));

      // 3. Check the sign (+ or -) and adjust the time accordingly
      if (offset.startsWith('+')) {
        now = now.add(Duration(hours: offsetHours));
      } else {
        now = now.subtract(Duration(hours: offsetHours));
      }

      debugPrint('Full Data: $data');
      debugPrint('The Offset is: $offset');

      // 4. Set the formatted time
      time = DateFormat.jm().format(now);
    } catch (e) {
      debugPrint('caught error: $e');
      time = 'Retry connection';
    }
  }
}
