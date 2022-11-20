import 'package:flutter/material.dart';

import 'report.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/cloud.gif'),
              fit: BoxFit.cover
            )
          ),
          child: const Report(),
        ),
      ),
    );
  }
}