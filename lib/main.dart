import 'package:flutter/material.dart';
import './home.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Catatan Keuangan",
      theme: ThemeData(primaryColor: Colors.orange),
      home: new Home(),
    );
  }
}
