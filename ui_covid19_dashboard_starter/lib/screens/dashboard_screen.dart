import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_covid19_dashboard_starter/data/data_point.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final values = [
      9231249,
      123214,
      51245,
      7452340,
    ];
    final List<DataPoint> dataPoints = [
      DataPoint.casesTotal,
      DataPoint.casesAcitve,
      DataPoint.deaths,
      DataPoint.recovered,
    ];

    return ListView.builder(
      itemCount: dataPoints.length,
      itemBuilder: (context, index) {
        final formattedValue = NumberFormat('#,##0').format(values[index]);

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataPoints[index].name,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: dataPoints[index].color,
                        ),
                      ),
                      Image.asset(
                        dataPoints[index].assetPath,
                        color: dataPoints[index].color,
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    formattedValue,
                    style: TextStyle(
                      fontSize: 26.0,
                      color: dataPoints[index].color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
