import 'package:flutter/material.dart';

enum DataPoint {
  casesTotal('Total Cases', 'assets/count.png', Color(0xffFFF492)),
  casesAcitve('Active Cases', 'assets/fever.png', Color(0xFFE99600)),
  deaths('Deaths', 'assets/death.png', Color(0xFFE40000)),
  recovered('Recovered', 'assets/patient.png', Color(0xFF70A901));

  const DataPoint(this.name, this.assetPath, this.color);
  final String name;
  final String assetPath;
  final Color color;
}
