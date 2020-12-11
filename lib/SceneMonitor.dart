import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class sceneMonitor extends StatefulWidget {
  @override
  _sceneMonitorState createState() => _sceneMonitorState();
}

class _sceneMonitorState extends State<sceneMonitor> {

  final dbRef = FirebaseDatabase.instance.reference();

  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(
        stream: dbRef.child("data").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError && snapshot.data.snapshot.value != null) {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Temperature",
                            style:
                            TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.snapshot.value['temperature'].toString() + "°C",
                            style:
                            TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Humidity",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data.snapshot.value['humidity'].toString() + "%", // dummy value
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Distance",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data.snapshot.value['distance'].toString() + " cm", // dummy value
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }else {
             return new Container(
               child: new Text("Gagal Connect"),
             );
          }
        }),
    );
  }
}
