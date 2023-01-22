import 'package:flutter/material.dart';
import 'package:sleepingdata/widgets/custombarchart.dart';
import 'package:sleepingdata/model/culumchartmodel.dart';
import 'package:sleepingdata/widgets/customdoughnutchart.dart';

class GraphPage extends StatefulWidget {
  static String id = 'GraphPage';
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    List<CulomnChartData> chartData = [
      CulomnChartData('person1', 59, 117, 277, 28),
      CulomnChartData('person2', 42, 115, 335, 53),
      CulomnChartData('person3', 46, 114, 290, 27),
      CulomnChartData('person4', 18, 98, 163, 83),
      CulomnChartData('person5', 46, 114, 290, 27),
      CulomnChartData('person6', 18, 98, 163, 83),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: bar_test(
                chartData: chartData,
              ),
            ),
            AspectRatio(
              aspectRatio: 1.5,
              child: Doughnut_test(
                data: [59, 117, 277, 28],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
