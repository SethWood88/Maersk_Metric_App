import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/sample_data.dart';
import '../../utils/widget_functions.dart';

class FilterDropDown extends StatelessWidget {
  FilterDropDown({super.key});

  List<String> items = [
    'API Name',
    'Uptime',
    'API Response Times',
  ];

  int i = 0;
  String? selectedItem = 'API Name';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isSwitched = true;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.white12,
          title: const Text(
            'Filters',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          centerTitle: true),
      body: Column(
        children: [
          const Center(
            child: Text('Individual API Notifications',
                style: TextStyle(fontSize: 20, color: Colors.white24),
                textAlign: TextAlign.left),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.hardEdge,
                physics: const BouncingScrollPhysics(),
                itemCount: IndividualAPIData.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      IndividualAPIData.data[index].apiName
                          .toString(),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 25),
                    ),
                    trailing: CupertinoSwitch(
                      // overrides the default green color of the track
                      activeColor: Colors.white,
                      // color of the round icon, which moves from right to left
                      thumbColor: Colors.green.shade900,
                      // when the switch is off
                      trackColor: Colors.black12,
                      // boolean variable value
                      value: isSwitched,
                      // changes the state of the switch
                      onChanged: (value) => isSwitched = value,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class FilterApis extends StatelessWidget {
  final String apiName;
  final int id;

  const FilterApis({required this.apiName, required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            child: Text(
              apiName,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
