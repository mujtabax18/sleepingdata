import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sleepingdata/model/culumchartmodel.dart';

class Doughnut_test extends StatefulWidget {
  Doughnut_test({
    Key? key,
    required this.data,
  }) : super(key: key);

  List<double> data;
  @override
  State<Doughnut_test> createState() => _Doughnut_testState();
}

class _Doughnut_testState extends State<Doughnut_test> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = getdata();
    // TODO: implement initState
    super.initState();
  }

  List<ChartData> getdata() {
    List<ChartData> templist = [];
    List<String> tempLegends = ['awake', 'REM', 'light', 'Deep'];
    List<Color> tempColor = [
      Color(0xff6043FF),
      Color(0xffD671F4),
      Color(0xffFE987F),
      Color(0xffFFCF43)
    ];
    for (var i = 0; i < widget.data.length; i++) {
      templist.add(ChartData(tempLegends[i], widget.data[i], tempColor[i]));
    }
    return templist;
  }

  late List<ChartData> chartData;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
          child: SfCircularChart(
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ])),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
