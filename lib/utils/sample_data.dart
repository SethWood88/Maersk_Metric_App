import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metrics_app/Screens/FiltersPage/Filter.dart';
import 'package:metrics_app/widgets/IndividualWidget.dart';




// ignore: non_constant_identifier_names
class DowntimeData{
static List<DowntimeD> data = [
  DowntimeD(id: 0, apiName: 'Fractus API', outage: DateTime.parse('2022-09-11 20:18:04Z'), inteval: 30, downtime: 1.1, p: 'P1', ),
  DowntimeD(id: 1, apiName: 'Aurum Admin Prod01', outage: DateTime.parse('2022-09-11 16:11:04Z'), inteval: 30, downtime: 1.6, p: 'P2' ),
  DowntimeD(id: 2, apiName: 'Viprs Indicum', outage: DateTime.parse('2022-07-11 10:28:04Z'), inteval: 30, downtime: 1.9, p: 'P1' ),
  DowntimeD(id: 2, apiName: 'Sample', outage: DateTime.parse('2022-07-11 10:28:04Z'), inteval: 30, downtime: 1.9, p: 'P1' ),
  DowntimeD(id: 2, apiName: 'Sample', outage: DateTime.parse('2022-07-11 10:28:04Z'), inteval: 30, downtime: 1.9, p: 'P2' ),

];
}

class DowntimeD{
  final String? p;
  final int id;
  final DateTime outage;
  final int inteval;
  final double downtime;
  final String? apiName;

  const DowntimeD({
    required this.p,
    required this.id,
    required this.outage,
    required this.inteval,
    required this.downtime,
    required this.apiName,
});
}
class IndividualAPIData{
  static List<APIData> data = [
    APIData(id: 0, apiName: "Fractus API", uptime: "98%", status: "LIVE"),
    APIData(id: 1, apiName: "tms-api", uptime: "97%", status: "LIVE"),
    APIData(id: 2, apiName: "PS API 6", uptime: "100%", status: "LIVE"),
    APIData(id: 3, apiName: "Processus", uptime: "100%", status: "LIVE"),
    APIData(id: 4, apiName: "APP UNK", uptime: "99%", status: "LIVE"),
    APIData(id: 5, apiName: "VIPRS Indicum", uptime: "100%", status: "DOWN"),
    APIData(id: 6, apiName: "Process VSCM", uptime: "98%", status: "LIVE"),
    APIData(id: 7, apiName: "Vipers API", uptime: "94%", status: "LIVE"),
    APIData(id: 8, apiName: "Aurum Admin Prod01", uptime: "100%", status: "DOWN"),


  ];
}
class APIData {
  // for ordering in the graph
  final int id;
  final String apiName;
  final String uptime;
  final String? status;

  const APIData({
    required this.status,
    required this.id,
    required this.apiName,
    required this.uptime

  });
}

  var RE_DATA =
  {
    {"APIName": 'Fractus', "ID": "1", "Uptime": "94"},
    {"APIName":'Salutem', "ID": "1", "Uptime": "94"},
    {"APIName": 'VIPRS', "ID": "1", "Uptime": "94"},
  };



class BarData{
  static int interval = 1;

  static List<Data> barData = [
    Data(
        y:100,
        id:0
    ),
    Data(
     y:99,
     id:1
    ),
    Data(
        y:99,
        id:2
    ),
    Data(
        y:95,
        id:3
    ),
    Data(
        y:99,
        id:4
    ),
    Data(
        y:97,
        id:5
    ),
    Data(
        y:98,
        id:6
    ),
    Data(
        y:98,
        id:7
    ),
    Data(
        y:100,
        id:8
    ),
    Data(
        y:100,
        id:9
    ),
    Data(
        y:100,
        id:10
    ),Data(
        y:100,
        id:11
    ),
    Data(
        y:98,
        id:12
    ),
    Data(
        y:97,
        id:13
    ),
    Data(
        y:98,
        id: 14
    ),
    Data(
        y:99,
        id:15
    ),
    Data(
        y:92,
        id:16
    ),
    Data(
        y:96,
        id:17
    ),
    Data(
        y:99,
        id:18
    ),
    Data(
        y:94,
        id:19
    ),
    Data(
        y:99,
        id:20
    ),
    Data(
        y:96,
        id:21
    ),
    Data(
        y:96,
        id:22
    ),
    Data(
        y:97,
        id:23
    ),
    Data(
        y:97,
        id:24
    ),
    Data(
        y:99,
        id:25
    ),
    Data(
        y:99,
        id:26
    ),
    Data(
        y:99,
        id:27
    ),
    Data(
        y:99,
        id:28
    ),
    Data(
        y:99,
        id:29
    ),
    Data(
        y:100,
        id:30
    ),



  ];
}

class Data {
  // for ordering in the graph
  final int id;
  final double y;

  const Data({

    required this.id,
    required this.y,

  });
}
