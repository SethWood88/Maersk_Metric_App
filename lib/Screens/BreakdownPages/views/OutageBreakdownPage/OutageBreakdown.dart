import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/Models/OutageModel.dart';

import 'package:http/http.dart' as http;
import '../../../../Models/APIReportModel.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/widget_functions.dart';

class OutagesBreakdownPage extends StatefulWidget {
  OutagesBreakdownPage(
      {super.key, required this.OutageIndex, this.freshpingId});

  var OutageIndex;
  var freshpingId;

  @override
  State<OutagesBreakdownPage> createState() =>
      _OutagesBreakdownPageState(iIndex: OutageIndex, FreshPingID: freshpingId);
}

class _OutagesBreakdownPageState extends State<OutagesBreakdownPage> {
  _OutagesBreakdownPageState({required this.iIndex, required this.FreshPingID});

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<OutageModel>?> fetchData() async {
    final res = await http.get(Uri.parse(
        "https://wwa-salutemmetrics-ncus-prod.azurewebsites.net/api/v1/mttd/GetAllInstances/2023-01-01/page0"));
    if (res.statusCode == 200) {
      return OutageModel.fromArrayJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  var iIndex;
  var FreshPingID;

  @override
  Widget build(BuildContext context) {
    double containerwidth = 165;
    double containerheight = 40;

    return SafeArea(
        child: Scaffold(
      backgroundColor: COLOR_BLACK,
      body: FutureBuilder<List<OutageModel>?>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                throw Future.error('Data is empty');
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: CustomPaint(
                    painter: OutageBreakdownGraphic(),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            addHorizontalSpace(30),
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.arrow_back_rounded),
                              iconSize: 35,
                            ),
                            addHorizontalSpace(14),
                            Container(
                              width: 125,
                              height: 60,
                              child: Center(
                                child: Text(
                                  snapshot.data
                                          ?.elementAt(iIndex)
                                          .freshpingid
                                          .toString() ??
                                      '',
                                  style: TextStyle(
                                      color: COLOR_WHITE, fontSize: 26),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: COLOR_BLACK),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                addVerticalSpace(10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: DARKBLUE,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      AutoSizeText('OUTAGE DURATION',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: COLOR_WHITE,
                                          )),
                                      addHorizontalSpace(10),
                                      Row(
                                        children: [
                                          addHorizontalSpace(130),
                                          AutoSizeText(
                                            snapshot.data
                                                    ?.elementAt(iIndex)
                                                    .duration
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: COLOR_WHITE),
                                          ),
                                          addHorizontalSpace(5),
                                          Text(
                                            'MIN',
                                            style: TextStyle(
                                                color: COLOR_WHITE,
                                                fontSize: 26),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                addVerticalSpace(10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: DARKBLUE,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        'DETECTED DATETIME',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24, color: COLOR_WHITE),
                                      ),
                                      addVerticalSpace(10),
                                      Center(
                                        child: Container(
                                          width: containerwidth,
                                          height: containerheight,
                                          child: AutoSizeText(
                                            snapshot.data
                                                    ?.elementAt(iIndex)
                                                    .detectedDateTime
                                                    .toString() ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: COLOR_WHITE),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                addVerticalSpace(10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: DARKBLUE,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        'RESOLVED DATETIME',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24, color: COLOR_WHITE),
                                      ),
                                      addVerticalSpace(10),
                                      Center(
                                        child: Container(
                                          width: containerwidth,
                                          height: containerheight,
                                          child: AutoSizeText(
                                            snapshot.data
                                                ?.elementAt(iIndex)
                                                .resolvedDateTime
                                                .toString() ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: COLOR_WHITE),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                addVerticalSpace(10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: DARKBLUE,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        'CREATED DATETIME',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24, color: COLOR_WHITE),
                                      ),
                                      addVerticalSpace(10),
                                      Center(
                                        child: Container(
                                          width: containerwidth,
                                          height: containerheight,
                                          child: AutoSizeText(
                                            snapshot.data
                                                ?.elementAt(iIndex)
                                                .createdDateTime
                                                .toString() ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: COLOR_WHITE),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: DARKBLUE,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        'OUTAGE ID',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24, color: COLOR_WHITE),
                                      ),
                                      addVerticalSpace(10),
                                      Center(
                                        child: Container(
                                          width: containerwidth,
                                          height: containerheight,
                                          child: AutoSizeText(
                                            snapshot.data
                                                ?.elementAt(iIndex)
                                                .outageId
                                                .toString() ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: COLOR_WHITE),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              throw Future.error('Connection Failed');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ));
  }
}
