import 'package:flutter/material.dart';
import 'services/world_clock.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading...';

  void setupWorldClock() async {
    WorldClock instance = WorldClock(
      location: 'Berlin',
      flag: 'germany.png',
      url: 'Europe/Berlin',
    );

    await instance.getTime();

    // FIXED: The 'mounted' check prevents the "async gap" error
    if (!mounted) return;

    setState(() {
      time = instance.time;
    });

    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldClock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(child: SpinKitHourGlass(color: Colors.white, size: 50.0)),
    );
  }
}
