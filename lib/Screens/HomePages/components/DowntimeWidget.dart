import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/Models/OutageModel.dart';
import 'package:http/http.dart' as http;
import '../../../Models/APIReportModel.dart';
import '../../../utils/constants.dart';
import '../../../utils/sample_data.dart';

class DowntimeWidget extends StatefulWidget {
  const DowntimeWidget({super.key});

  @override
  State<DowntimeWidget> createState() => _DowntimeWidgetState();
}

class _DowntimeWidgetState extends State<DowntimeWidget> {
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
    return FutureBuilder<List<OutageModel>?>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              throw Future.error('Data is empty');
            } else {
              return ListView.builder(
                  itemCount: DowntimeData.data.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    var item = snapshot.data?.length;
                    return Card(
                        color: DANGER,
                        child: ListTile(
                          onTap: () => Get.toNamed('/outage_report/${snapshot.data?.elementAt(index).freshpingid}'),
                          leading: SizedBox(
                            width: 100,
                            child: AutoSizeText(
                              snapshot.data
                                      ?.elementAt(index)
                                      .freshpingid
                                      .toString() ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 16, color: COLOR_WHITE),
                              maxLines: 3,
                            ),
                          ),
                          trailing:
                              AutoSizeText(snapshot.data?.elementAt(index).detectedDateTime.toString() ?? '', maxLines: 1),
                        ));
                  });
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            throw Future.error('Connection Failed');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
