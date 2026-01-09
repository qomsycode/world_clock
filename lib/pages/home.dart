import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // We add 'as Map' to tell Flutter what type of data this is
    // The '!' tells Flutter the route definitely has arguments
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    // debugPrint needs a String, so we add .toString()
    debugPrint(data.toString());
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: () async {
                // Added 'async' here
                dynamic result = await Navigator.pushNamed(
                  context,
                  '/location',
                );
                if (result != null) {
                  // Add this check to prevent errors if user hits 'back'
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'flag': result['flag'], // Don't forget the flag!
                    };
                  });
                }
              },
              icon: Icon(Icons.edit_location),
              label: Text('Edit location'),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data['location'],
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              data['time'],
              style: TextStyle(
                fontSize: data['time'] == 'Retry connection' ? 28.0 : 66.0,
                color: data['time'] == 'Retry connection'
                    ? Colors.red
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
