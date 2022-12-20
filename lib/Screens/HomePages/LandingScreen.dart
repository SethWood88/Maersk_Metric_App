import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/Screens/BreakdownPages/MonthlyBreakdownPage/MonthlyBreakdown.dart';
import 'package:metrics_app/Controllers/SalutemController.dart';
import 'package:http/http.dart' as http;

import '../../Models/IndividualAPIModel.dart';

class Options extends StatefulWidget {
  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }




  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: FutureBuilder(
                        future: _fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            return Text(data.toString());
                          } else {
                            return const CircularProgressIndicator();
                          }
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String url =
    "https://10.0.2.2:44343//api/v1/GetCheckFreshPingMetrics/813220/0001-01-01";

_fetchData() async {
   Dio dio = Dio();
   dio.options.baseUrl = url;
   dio.options.connectTimeout = 10000;
   dio.options.receiveTimeout = 30000;
   Response<IndividualAPIModel> response = await dio.get(url);

   return response;
}