import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/Models/APIReportModel.dart';
import 'package:metrics_app/Screens/HomePages/views/Home.dart';
import 'package:metrics_app/utils/sample_data.dart';
import 'package:http/http.dart' as http;
import '../../../../CustomObjects/Graphs.dart';
import '../../../../CustomObjects/OutlineGraphic.dart';
import '../../../../Models/APIStatusModel.dart';
import '../../../../Models/OutageModel.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/endpoints.dart';
import '../../../../utils/widget_functions.dart';

class IndividualBreakdownPage extends StatefulWidget {
  IndividualBreakdownPage(
      {required this.individualIndex, required this.freshpingid});

  final int individualIndex;
  final String? freshpingid;

  @override
  State<IndividualBreakdownPage> createState() =>
      _ReportWidgetState(iIndex: individualIndex);
}

class _ReportWidgetState extends State<IndividualBreakdownPage> {
  _ReportWidgetState({required this.iIndex});

  var iIndex;
  var FreshPingID;

  final bool vertical = false;
  final List<bool> _selectedGraphs = <bool>[true, false];
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<APIReportModel>?> fetchData() async {
    final res = await http.get(Uri.parse(
        "https://wwa-salutemmetrics-ncus-prod.azurewebsites.net/api/v1/GetAllCheckFreshPingMetrics/Page0/2023-1-01"));
    if (res.statusCode == 200) {
      return APIReportModel.fromArrayJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = 175;
    double boxHeight = 70;
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BLACK,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: FutureBuilder<List<APIReportModel>?>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  throw Future.error('Data is empty');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: SizedBox(
                          width: size.width,
                          height: size.height - 24,
                          child: ClipRRect(
                            clipBehavior: Clip.none,
                            child: Stack(
                              children: [
                                Container(
                                  child: CustomPaint(
                                    painter: IndividualBreakdownGraphic(),
                                  ),
                                ),
                                Container(
                                  width: size.width,
                                  height: size.height,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 60, 10, 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: COLOR_BLACK),
                                ),
                                Row(
                                  children: [
                                    addHorizontalSpace(30),
                                    Container(
                                        child: IconButton(
                                      onPressed: () => Get.back(),
                                      icon:
                                          const Icon(Icons.arrow_back_rounded),
                                      iconSize: 30,
                                    )),
                                    addHorizontalSpace(20),
                                    Container(
                                      width: 120,
                                      height: 60,
                                      child: Center(
                                        child: AutoSizeText(
                                          textAlign: TextAlign.center,
                                          snapshot.data
                                                  ?.elementAt(iIndex)
                                                  .checkname
                                                  .toString() ??
                                              '',
                                          maxLines: 2,
                                          maxFontSize: 30,
                                          style: TextStyle(
                                              color: COLOR_WHITE, fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 70, 0, 0),
                                        child: ToggleButtons(
                                            color: Colors.grey,
                                            fillColor: COLOR_GREY,
                                            focusColor: Colors.white,
                                            disabledBorderColor: COLOR_GREY,
                                            splashColor: Colors.white,
                                            selectedColor: COLOR_WHITE,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onPressed: (int newIndex) {
                                              setState(() {
                                                for (int index = 0;
                                                    index <
                                                        _selectedGraphs.length;
                                                    index++) {
                                                  if (index == newIndex) {
                                                    _selectedGraphs[index] =
                                                        true;
                                                    _controller.animateToPage(
                                                        index,
                                                        duration:
                                                            const Duration(
                                                                microseconds:
                                                                    500),
                                                        curve: Curves.ease);
                                                  } else {
                                                    _selectedGraphs[index] =
                                                        false;
                                                  }
                                                }
                                              });
                                            },
                                            constraints: BoxConstraints(
                                                minHeight: 30, minWidth: 178),
                                            isSelected: _selectedGraphs,
                                            children: timeFrameList),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    addVerticalSpace(260),
                                    AutoSizeText(
                                      maxLines: 1,
                                      'Uptime',
                                      style: TextStyle(
                                          fontSize: 28, color: COLOR_WHITE),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 160, 20, 380),
                                  child: IndividualLineChartWidget(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      addVerticalSpace(310),
                                      Row(
                                        children: [
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue200),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 70,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      'UPTIME',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(35),
                                                Container(
                                                    width: 55,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      snapshot.data
                                                              ?.elementAt(
                                                                  iIndex)
                                                              .totalUptimePercent
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          addHorizontalSpace(10),
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue200),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 85,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      'DOWNTIME PERCENTAGE',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(25),
                                                Container(
                                                    width: 40,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      snapshot.data
                                                              ?.elementAt(
                                                                  iIndex)
                                                              .totalDowntimePercent
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      addVerticalSpace(10),
                                      Row(
                                        children: [
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue400),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 80,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      'API RESPONSE TIME',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(20),
                                                Container(
                                                    width: 50,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      '413ms',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          addHorizontalSpace(10),
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue400),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 70,
                                                    child: AutoSizeText(
                                                      maxLines: 3,
                                                      'UI RESPONSE TIME',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(25),
                                                Container(
                                                    width: 60,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      '0ms',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      addVerticalSpace(10),
                                      Row(
                                        children: [
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue600),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 80,
                                                    child: AutoSizeText(
                                                      maxLines: 3,
                                                      'TOTAL NUMBER OF OUTAGES',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(40),
                                                Container(
                                                    width: 30,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      '1',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          addHorizontalSpace(10),
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue600),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 85,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      'LAST OUTAGE DURATION',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(10),
                                                Container(
                                                  width: 60,
                                                  child: Row(
                                                    children: [
                                                      AutoSizeText(
                                                        maxLines: 1,
                                                        snapshot.data
                                                                ?.elementAt(
                                                                    iIndex)
                                                                .averageOutageDuration
                                                                .toString() ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            wordSpacing: 1),
                                                      ),
                                                      AutoSizeText(
                                                        ' MIN',
                                                        style: TextStyle(
                                                            color: COLOR_WHITE,
                                                            fontSize: 14),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      addVerticalSpace(10),
                                      Row(
                                        children: [
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue700),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 80,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      'MEAN TIME TO DETECT',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(20),
                                                Container(
                                                    width: 60,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      '3 MIN',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          addHorizontalSpace(10),
                                          Container(
                                            width: boxWidth,
                                            height: boxHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Blue700),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                addHorizontalSpace(10),
                                                Container(
                                                    width: 50,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      'ERROR LOGS',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    )),
                                                addHorizontalSpace(40),
                                                Container(
                                                    width: 60,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      '0',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                throw Future.error("Connection Failed");
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  renderProperty(String title, Color color, String value) {
    return Expanded(
        child: Container(
      height: 58,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)), color: color),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text(title,
                  style: TextStyle(fontSize: 12, color: Colors.white))),
          addHorizontalSpace(8),
          Expanded(
              flex: 2,
              child: Text(value,
                  style: TextStyle(fontSize: 18, color: Colors.white))),
        ],
      ),
    ));
  }
}

const List<Widget> timeFrameList = <Widget>[
  Text(
    'Today',
    textAlign: TextAlign.center,
  ),
  Text('Last Month', textAlign: TextAlign.center),
];

class Top4Boxes extends StatefulWidget {
  const Top4Boxes({Key? key, required TopIndex}) : super(key: key);

  @override
  State<Top4Boxes> createState() => _Top4BoxesState();
}

class _Top4BoxesState extends State<Top4Boxes> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<APIReportModel>?> fetchData() async {
    final res = await http.get(Uri.parse(
        "https://wwa-salutemmetrics-ncus-prod.azurewebsites.net/api/v1/GetAllCheckFreshPingMetrics/Page0/2023-1-01"));
    if (res.statusCode == 200) {
      return APIReportModel.fromArrayJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  var iIndex;

  @override
  Widget build(BuildContext context) {
    double boxWidth = 175;
    double boxHeight = 70;
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<APIReportModel>?>(
        future: fetchData(),
        builder: (context, snapshot) {
          return Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addHorizontalSpace(10),
                Container(
                    width: 70,
                    child: AutoSizeText(
                      maxLines: 2,
                      'UPTIME',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                addHorizontalSpace(35),
                Container(
                    width: 55,
                    child: AutoSizeText(
                      maxLines: 1,
                      snapshot.data
                              ?.elementAt(iIndex)
                              .totalUptimePercent
                              .toString() ??
                          "",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )),
              ],
            ),
            addHorizontalSpace(10),
            Container(
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Blue200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addHorizontalSpace(10),
                  Container(
                      width: 85,
                      child: AutoSizeText(
                        maxLines: 2,
                        'DOWNTIME PERCENTAGE',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                  addHorizontalSpace(25),
                  Container(
                      width: 40,
                      child: AutoSizeText(
                        maxLines: 1,
                        snapshot.data
                                ?.elementAt(iIndex)
                                .totalDowntimePercent
                                .toString() ??
                            "",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                ],
              ),
            ),
            addVerticalSpace(10),
            Row(
              children: [
                Container(
                  width: boxWidth,
                  height: boxHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Blue400),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalSpace(10),
                      Container(
                          width: 70,
                          child: AutoSizeText(
                            maxLines: 3,
                            'UI RESPONSE TIME',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                      addHorizontalSpace(25),
                      Container(
                          width: 60,
                          child: AutoSizeText(
                            maxLines: 1,
                            '303ms',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ],
                  ),
                ),
                addHorizontalSpace(10),
                Container(
                  width: boxWidth,
                  height: boxHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Blue400),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalSpace(10),
                      Container(
                          width: 80,
                          child: AutoSizeText(
                            maxLines: 2,
                            'API RESPONSE TIME',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                      addHorizontalSpace(20),
                      Container(
                          width: 50,
                          child: AutoSizeText(
                            maxLines: 1,
                            '413ms',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ]);
        });
  }
}
