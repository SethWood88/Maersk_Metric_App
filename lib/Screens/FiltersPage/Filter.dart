import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metrics_app/Models/APIStatusModel.dart';
import '../../utils/endpoints.dart';
import '../../utils/sample_data.dart';
import '../../utils/widget_functions.dart';

class FilterDropDown extends StatefulWidget {
  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  List<String> items = [
    'API Name',
    'Uptime',
    'API Response Times',
  ];

  int i = 0;
  String? selectedItem = 'API Name';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<APIStatusModel>?> fetchData() async {
    final res = await http.get(Uri.parse("$baseProdURL/$APIStatus"));
    if (res.statusCode == 200) {
      return APIStatusModel.fromArrayJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load all API data");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isSwitched = true;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.white12,
          title: const Text(
            'API NOTIFICATIONS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          centerTitle: true),
      body: FutureBuilder<List<APIStatusModel>?>(
        future: fetchData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data == null){
              throw Future.error('Data is empty');
            } else{
              return SizedBox(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            clipBehavior: Clip.hardEdge,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  addVerticalSpace(5),
                                  Stack(children: [
                                    Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white10,
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data?.elementAt(index).name.toString() ?? '',
                                          style: TextStyle(color: Colors.white, fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 350, top: 10),
                                      child: CupertinoSwitch(
                                        // overrides the default green color of the track
                                        activeColor: Colors.white,
                                        // color of the round icon, which moves from right to left
                                        thumbColor: Colors.green.shade900,
                                        // when the switch is off
                                        trackColor: Colors.black12,
                                        // boolean variable value
                                        value: isSwitched,
                                        // changes the state of the switch
                                        onChanged: (value) => setState(() => isSwitched = value),
                                      ),
                                    )
                                  ]),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.none){
            throw Future.error('Connection Failed');
          } else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}

class FilterApis extends StatelessWidget {
  final String apiname;
  final int id;
  FilterApis(this.apiname, this.id);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Text(
              apiname,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
