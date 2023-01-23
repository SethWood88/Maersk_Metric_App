import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/Models/APIStatusModel.dart';
import 'package:metrics_app/Screens/BreakdownPages/views/IndividualBreakdownPage/IndividualBreakdown.dart';
import 'package:metrics_app/Screens/HomePages/Controllers/HomeController.dart';
import 'package:metrics_app/utils/widget_functions.dart';
import 'package:metrics_app/Screens/HomePages/components/ReportWidget.dart';
import 'package:http/http.dart' as http;
import '../../../Models/APIReportModel.dart';
import '../../../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<APIStatusModel>?> fetchData() async {
    final res = await http.get(Uri.parse(
        "https://wwa-salutemmetrics-ncus-prod.azurewebsites.net/api/v1/GetAllChecksCurrentStatus/Page0"));
    if (res.statusCode == 200) {
      return APIStatusModel.fromArrayJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_BLACK,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: [
              ReportWidget(),
              addVerticalSpace(10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CustomPaint(
                    painter: IndividualAPIGraphics(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      decoration: const BoxDecoration(
                          color: COLOR_BLACK,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: FutureBuilder<List<APIStatusModel>?>(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == null) {
                                return const Center(
                                  child: Text('Data is empty'),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      padding: const EdgeInsets.all(12),
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: DARKBLUE,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            IndividualBreakdownPage(
                                                                individualIndex:
                                                                    index, freshpingid: snapshot.data?.elementAt(index).name.toString() ?? '',)));
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  snapshot.data
                                                          ?.elementAt(index)
                                                          .name
                                                          .toString() ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                textColor: COLOR_WHITE,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return const Center(
                                child: Text('Connection Failed'),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
                ),
              )
            ])),
      ),
    );
  }
}
