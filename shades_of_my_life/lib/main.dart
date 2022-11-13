import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Shades(),
    );
  }
}

class Shades extends StatefulWidget {
  const Shades({super.key});

  @override
  State<Shades> createState() => _ShadesState();
}

class _ShadesState extends State<Shades> {
  int _shades = 854321;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _paint(context, details);
        });
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          _paint(context, details);
        });
      },
      child: Scaffold(
        backgroundColor: Color(0XFF000000 + _shades),
      ),
    );
  }

  void _paint(context, details) {
    double maxScr = MediaQuery.of(context).size.height;
    double yPos = details.globalPosition.dy;
    _shades = (yPos / maxScr * 16777215).round();
    if(_shades > 16777215) _shades = 16777215;
    // print(_shades);
  }
}