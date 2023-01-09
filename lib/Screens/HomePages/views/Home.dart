import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/utils/endpoints.dart';
import 'package:metrics_app/utils/widget_functions.dart';
import 'package:metrics_app/widgets/ReportWidget.dart';

import '../../../Models/IndividualAPIModel.dart';
import '../../../utils/constants.dart';

class B2CPage extends StatefulWidget {
  @override
  State<B2CPage> createState() => _B2CPageState();
}

class _B2CPageState extends State<B2CPage> {
  String? mtoken = "";

  @override
  void initState() {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: AveragedReport(),
      ),
    );
  }
}

class AveragedReport extends StatefulWidget {
  @override
  State<AveragedReport> createState() => _AveragedReportState();
}

class _AveragedReportState extends State<AveragedReport> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<AllAPIModel>?> fetchData() async {
    final res = await http.get(Uri.parse("$baseProdURL/$allAPIData"));
    if (res.statusCode == 200) {
      return AllAPIModel.fromArrayJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(children: [
          ReportWidget(),
          addVerticalSpace(10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: CustomPaint(
                painter: IndividualAPIGraphics(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                      color: COLOR_BLACK,
                      borderRadius: BorderRadius.all(Radius.circular(36))),
                  child: FutureBuilder<List<AllAPIModel>?>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == null) {
                            throw Future.error('Data is empty');
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.all(12),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, int index) {
                                return ListTile(
                                    title: Text(
                                  snapshot.data
                                          ?.elementAt(index)
                                          .name
                                          .toString() ??
                                      '',
                                  style: TextStyle(color: Colors.white),
                                ));
                              },
                            );
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          throw Future.error('Connection Failed');
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ),
          )
        ]));
  }
}
