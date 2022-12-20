import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Text('Individual API Notifications',style: TextStyle(fontSize: 20, color: Colors.white24), textAlign: TextAlign.left),
            ),
            Container(
              width: size.width,
              height: size.height,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                  clipBehavior: Clip.hardEdge,
                  physics: BouncingScrollPhysics(),
                  itemCount: IndividualAPIData.data.length,
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
                                IndividualAPIData.data[index].apiName.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 25),
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
