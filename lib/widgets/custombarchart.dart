import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sleepingdata/model/culumchartmodel.dart';

class bar_test extends StatefulWidget {
  bar_test({
    Key? key,
    required this.chartData,
  }) : super(key: key);
  List<CulomnChartData> chartData;
  @override
  State<bar_test> createState() => _bar_testState();
}

class _bar_testState extends State<bar_test> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Container(
            child: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.top,
                ),
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
              StackedColumnSeries<CulomnChartData, String>(
                dataSource: widget.chartData,
                xValueMapper: (CulomnChartData data, _) => data.x,
                yValueMapper: (CulomnChartData data, _) => data.y,
                name: 'awake',
                color: Color(0xff6043FF),
              ),
              StackedColumnSeries<CulomnChartData, String>(
                dataSource: widget.chartData,
                xValueMapper: (CulomnChartData data, _) => data.x,
                yValueMapper: (CulomnChartData data, _) => data.y2,
                name: 'REM',
                color: Color(0xffD671F4),
              ),
              StackedColumnSeries<CulomnChartData, String>(
                dataSource: widget.chartData,
                xValueMapper: (CulomnChartData data, _) => data.x,
                yValueMapper: (CulomnChartData data, _) => data.y3,
                name: 'light',
                color: Color(0xffFE987F),
              ),
              StackedColumnSeries<CulomnChartData, String>(
                dataSource: widget.chartData,
                xValueMapper: (CulomnChartData data, _) => data.x,
                yValueMapper: (CulomnChartData data, _) => data.y4,
                name: 'Deep',
                color: Color(0xffFFCF43),
              )
            ])));
  }
}
