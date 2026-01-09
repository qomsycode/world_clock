import 'package:flutter/material.dart';
// Step into the services folder from the current pages folder
import 'services/world_clock.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldClock> locations = [
    WorldClock(url: 'Africa/Lagos', location: 'Lagos', flag: 'nigeria.png'),
    WorldClock(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldClock(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldClock(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldClock(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldClock(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldClock(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldClock(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(int index) async {
    // Correct way to create a variable 'instance' from the list
    WorldClock instance = locations[index];
    await instance.getTime();

    // Check if the widget is still 'mounted' before popping to avoid errors
    if (!mounted) return;

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
    });
  }

  void getData() {
    //simulate network request for a username
    Future.delayed(Duration(seconds: 3), () {
      debugPrint('Qomzyy');
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(locations[index].location),
            ),
          );
        },
      ),

      //  body: TextButton(
      //   onPressed: () {
      //    setState(() {
      //   counter += 1;
      //   }
    );
    //   },
    //   child: Text('counter is $counter'),    ),
    // );
  }
}
