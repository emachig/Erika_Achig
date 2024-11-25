import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/altura.dart';


void main() {
  runApp(ParticipantApp());
}

class ParticipantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Altura(),
    );
  }
}