import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/Models/OutageModel.dart';
import 'package:metrics_app/Screens/BreakdownPages/controllers/outages_breakdown_controller.dart';
import 'package:http/http.dart' as http;
import '../../../../Models/APIReportModel.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/widget_functions.dart';

class OutagesBreakdownPage extends StatefulWidget {
  const OutagesBreakdownPage({super.key});

  @override
  State<OutagesBreakdownPage> createState() => _OutagesBreakdownPageState();
}

class _OutagesBreakdownPageState extends State<OutagesBreakdownPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<OutageModel>?> fetchData() async {
    final res = await http.get(Uri.parse(
        "https://wwa-salutemmetrics-ncus-prod.azurewebsites.net/api/v1/GetAllCheckFreshPingMetrics/Page0/2023-1-01"));
    if (res.statusCode == 200) {
      return OutageModel.fromArrayJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: COLOR_BLACK,
      body: FutureBuilder<OutageModel>(builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          throw Future.error('Data is empty');
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustomPaint(
              painter: OutageBreakdownGraphic(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalSpace(20),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_rounded),
                        iconSize: 30,
                      ),
                      addHorizontalSpace(32),
                      Column(
                        children: [
                          AutoSizeText(
                            '',
                            maxLines: 1,
                            style: const TextStyle(
                                color: COLOR_WHITE, fontSize: 24),
                          ),
                          const Text(
                            'OUTAGE REPORT',
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: COLOR_BLACK),
                    // child: ,
                  ))
                ],
              ),
            ),
          );
        }
      }),
    ));
  }
}
