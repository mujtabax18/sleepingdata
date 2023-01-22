import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:sleepingdata/model/doughnutchartmodel.dart';
import 'package:sleepingdata/widgets/custombarchart.dart';
import 'package:sleepingdata/model/culumchartmodel.dart';
import 'package:sleepingdata/widgets/customdoughnutchart.dart';
import 'package:sleepingdata/model/getdata.dart';
import 'package:sleepingdata/data/rawdata.dart';
import 'package:sleepingdata/contacts/color.dart';

class GraphPage extends StatefulWidget {
  static String id = 'GraphPage';
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  late GetData tempGetData;
  late List<String> subjectList;
  late List<String> propertyList;
  late List<CulomnChartData> culomnChartData;
  late List<DoughnutChartData> doughnutChartData;
  int _selectedSubject = 0;

  @override
  void initState() {
    tempGetData = GetData(RawData: RawData);
    subjectList = tempGetData.GetSubjectsList();
    propertyList = tempGetData.GetPropertyList();
    Updatedata(subjectList[_selectedSubject]);
    // TODO: implement initState
    super.initState();
  }

  void Updatedata(String subject) {
    List<int> awake = tempGetData.GetSubjectPropertyValue(subject, 'awake');
    List<int> rem = tempGetData.GetSubjectPropertyValue(subject, 'REM');
    List<int> light = tempGetData.GetSubjectPropertyValue(subject, 'Light');
    List<int> deep = tempGetData.GetSubjectPropertyValue(subject, 'Deep');
    print(awake);
    culomnChartData = getculomnchartdata(
      awake: awake,
      rem: rem,
      light: light,
      deep: deep,
    );
    doughnutChartData = getdoughChartDate(
      awake: awake,
      rem: rem,
      light: light,
      deep: deep,
    );
  }

  List<CulomnChartData> getculomnchartdata({
    required List<int> awake,
    required List<int> rem,
    required List<int> light,
    required List<int> deep,
  }) {
    List<CulomnChartData> tempList = [];
    for (var i = 0; i < awake.length; i++) {
      tempList
          .add(CulomnChartData('Day$i', awake[i], rem[i], light[i], deep[i]));
    }
    return tempList;
  }

  List<DoughnutChartData> getdoughChartDate({
    required List<int> awake,
    required List<int> rem,
    required List<int> light,
    required List<int> deep,
  }) {
    List<DoughnutChartData> templist = [];
    List tempvaluelist = [awake, rem, light, deep];
    for (var i = 0; i < tempvaluelist.length; i++) {
      double sum = 0;
      tempvaluelist[i].forEach((e) => sum += e);
      templist.add(
        DoughnutChartData(
          propertyList[i],
          sum,
          kColorLegendList[i],
        ),
      );
    }
    return templist;
  }

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
                chartData: culomnChartData,
              ),
            ),
            AspectRatio(
              aspectRatio: 1.5,
              child: Doughnut_test(
                chartData: doughnutChartData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
