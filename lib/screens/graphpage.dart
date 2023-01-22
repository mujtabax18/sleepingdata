import 'package:dropdown_button2/dropdown_button2.dart';
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
    for (var i = 0; i <= 30; i++) {
      tempList.add(
        CulomnChartData(
          '${i + 1}',
          awake.length - 1 < i ? 0 : awake[i],
          rem.length - 1 < i ? 0 : rem[i],
          light.length - 1 < i ? 0 : light[i],
          deep.length - 1 < i ? 0 : deep[i],
        ),
      );
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
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: mediaQuery.height / 5,
              decoration: BoxDecoration(
                color: Color(0xff9D80FE),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Sleep Data:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              _selectedSubject = subjectList.indexOf(value);
                              Updatedata(subjectList[_selectedSubject]);
                            });
                          },
                          initialValue: subjectList[_selectedSubject],
                          child: Center(
                              child: Text('${subjectList[_selectedSubject]}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ))),
                          itemBuilder: (context) {
                            return List.generate(subjectList.length, (index) {
                              return PopupMenuItem(
                                value: subjectList[index],
                                child: Text('${subjectList[index]}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    )),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'SLEEP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Day',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Week',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Month',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('2023-01-22, Sun')),
            bar_test(
              chartData: culomnChartData,
            ),
            Doughnut_test(
              chartData: doughnutChartData,
            ),
          ],
        ),
      ),
    );
  }
}
