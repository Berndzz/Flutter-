import 'package:flutter/material.dart';
import 'package:mini_project_04/Camera.dart';
import 'package:mini_project_04/SceneMonitor.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        'SceneMonitor': (BuildContext context) => sceneMonitor(),
      },
      title: 'ProgHybrid Project',
      debugShowCheckedModeBanner: false,
      home: Dashbord(),
    );
  }
}

class Dashbord extends StatefulWidget {
  @override
  _DashbordState createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord>
    with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("Monitoring & Take Image Hardware "),
        bottom: new TabBar(
          controller: controller,
          tabs: [
            new Tab(
              icon: new Icon(Icons.ac_unit_outlined), text: "Temperature",),
            new Tab(icon: new Icon(Icons.camera_alt), text: "Ambil gambar",),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: [
          sceneMonitor(),
          camera(),
        ],
      ),
    );
  }
}
