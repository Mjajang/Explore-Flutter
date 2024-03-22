// ignore_for_file: public_member_api_docs, sort_constructors_first
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

    return ListView(
      children: [
        for (final dataPoint in DataPoint.values)
          DataPointCard(
            dataPoint: dataPoint,
            value: values[dataPoint.index],
          ),
      ],
    );
  }
}

class DataPointCard extends StatelessWidget {
  const DataPointCard({
    super.key,
    required this.dataPoint,
    required this.value,
  });
  final DataPoint dataPoint;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        // color: Colors.blue.shade900, // Change the color of the card ligth variant
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataPoint.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: dataPoint.color),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    dataPoint.assetPath,
                    color: dataPoint.color,
                    height: 48,
                  ),
                  Text(
                    NumberFormat('#,###,###,###').format(value),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: dataPoint.color,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
