import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/Models/OutageModel.dart';
import 'package:http/http.dart' as http;
import 'package:metrics_app/Screens/BreakdownPages/views/OutageBreakdownPage/OutageBreakdown.dart';
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
        "https://wwa-salutemmetrics-ncus-prod.azurewebsites.net/api/v1/mttd/GetAllInstances/2023-01-01/page0"));
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
                  itemCount: snapshot.data?.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    return Card(
                        color: DANGER,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OutagesBreakdownPage(
                                          OutageIndex: index,
                                          freshpingId: snapshot.data
                                                  ?.elementAt(index)
                                                  .freshpingid
                                                  .toString() ??
                                              '',
                                        )));
                          },
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
                          trailing: AutoSizeText(
                              snapshot.data
                                      ?.elementAt(index)
                                      .detectedDateTime
                                      .toString() ??
                                  '',
                              maxLines: 1),
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
