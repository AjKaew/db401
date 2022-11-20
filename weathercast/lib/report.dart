import 'package:flutter/material.dart';
import 'package:weathercast/forecast.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void initState() {
    forecast()
    .then(
      (weather) => print('${weather.condition}, ${weather.symbol}')
    )
    .catchError(
      (error) => print(error)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'สภาพอากาศวันนี้',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        Container(
          constraints: const BoxConstraints.tightFor(
            width: 150,
            height: 150
          ),
          decoration: BoxDecoration(
            color: Colors.blueAccent.shade700.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)
          ),
          margin: const EdgeInsets.symmetric(vertical: 30),
        ),
        ElevatedButton(
          onPressed: () {}, 
          child: const Text('Refresh')
        )
      ],
    );
  }
}