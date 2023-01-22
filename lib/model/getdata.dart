import 'package:flutter/material.dart';
import 'package:sleepingdata/model/culumchartmodel.dart';

class GetData {
  GetData({
    required this.RawData,
  });
  var RawData;
  List<String> GetSubjectsList() {
    List<String> templist = [];
    RawData.forEach((k, v) => templist.add(k));
    return templist;
  }

  List<String> GetPropertyList() {
    List<String> templist = [];
    RawData.forEach((k, v) {
      v.forEach((key, value) {
        templist.add(key);
      });
    });
    return templist.toSet().toList();
  }

  List<int> GetSubjectPropertyValue(String sub, String property) {
    List<int> tempdata = [];
    RawData.forEach((key, value) {
      if (key == sub) {
        value.forEach((key, value) {
          if (key == property) {
            tempdata = value;
          }
        });
      }
    });
    return tempdata;
  }
}
