// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/Screens/BreakdownPages/IndividualBreakdownPage/IndividualBreakdown.dart';
import 'package:metrics_app/utils/endpoints.dart';
import 'package:metrics_app/widgets/DownedAPIs.dart';
import 'package:metrics_app/widgets/IndividualWidget.dart';
import 'package:metrics_app/widgets/ReportWidget.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/utils/constants.dart';
import 'package:metrics_app/utils/widget_functions.dart';
import 'package:metrics_app/utils/sample_data.dart';
import 'package:http/http.dart' as http;
import '';
import '../../../Models/IndividualAPIModel.dart';

class B2CPage extends StatefulWidget {
  @override
  State<B2CPage> createState() => _B2CPageState();
}

class _B2CPageState extends State<B2CPage> {
  String? mtoken = "";

  void initstate() {
    super.initState();

    requestPermission();
    getToken();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My token is $mtoken");
      });
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied access');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: AveragedReport(),
        ),
      ),
    );
  }
}

class AveragedReport extends StatefulWidget {
  @override
  State<AveragedReport> createState() => _AveragedReportState();
}

class _AveragedReportState extends State<AveragedReport> {
  late Future<AllAPIModel> data;

  @override
  void initstate() {
    super.initState();
    data = fetchData();
  }

  Future<AllAPIModel> fetchData() async {
    final res = await http.get("$baseProdURL/$allAPIData" as Uri);
    if (res.statusCode == 200) {
      return AllAPIModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(children: [
          Row(
            children: [
              ClipRRect(
                child: ReportWidget(),
              )
            ],
          ),
          addVerticalSpace(10),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              height: 349,
              width: 400,
              child: Stack(children: [
                Container(
                  color: Colors.black,
                  clipBehavior: Clip.none,
                  child: CustomPaint(
                    size: Size(400, 1000),
                    painter: IndividualAPIGraphics(),
                  ),
                ),
                Center(
                  child: Container(
                    width: 370,
                    height: 325,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: COLOR_BLACK,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: FutureBuilder(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == null) {
                                throw Future.error('Data is empty');
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, int index) {
                                    return ListTile(
                                        title: Text((snapshot.data as DocumentSnapshot)[index]
                                                ['name']
                                            .toString()));
                                  },
                                );
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.none) {
                              throw Future.error('Connnection Failed');
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ]));
  }
}
