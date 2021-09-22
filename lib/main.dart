import 'package:flutter/material.dart';
import 'package:google_maps/pages/map_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapPage(),
    );
  }
}
