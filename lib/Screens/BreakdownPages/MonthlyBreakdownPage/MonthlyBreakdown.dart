import 'package:flutter/material.dart';
import 'package:metrics_app/Screens/HomePages/views/Home.dart';
import 'package:metrics_app/utils/sample_data.dart';
import 'package:metrics_app/widgets/ReportWidget.dart';

import '../../../CustomObjects/Graphs.dart';
import '../../../CustomObjects/OutlineGraphic.dart';
import '../../../utils/constants.dart';
import '../../../utils/widget_functions.dart';

class ReportWidgetBreakdown extends StatefulWidget {
  @override
  State<ReportWidgetBreakdown> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidgetBreakdown> {
  final List<bool> _selectedGraphs = <bool>[true, false, false, false, false];
  bool vertical = false;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BLACK,
        body: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustomPaint(
              painter: IndividualBreakdownGraphic(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 24),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => B2CPage()));
                            },
                            icon: const Icon(Icons.arrow_back_rounded),
                            iconSize: 30,
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 24),
                        child: Column(
                          children: [
                            const Text(
                              'MONTH\nBREAKDOWN',
                              style:
                                  TextStyle(color: COLOR_WHITE, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //     child: IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(Icons.settings_sharp),
                      //       iconSize: 25,
                      //     )),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: COLOR_BLACK),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            height: 300,
                            child: PageView(
                              clipBehavior: Clip.none,
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller,
                              children: [LineChartWidget(), DowntimeWidget()],
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.hardEdge,
                              child: ToggleButtons(
                                  color: Colors.grey,
                                  fillColor: COLOR_GREY,
                                  focusColor: Colors.white,
                                  disabledBorderColor: COLOR_GREY,
                                  splashColor: Colors.white,
                                  selectedColor: COLOR_WHITE,
                                  borderRadius: BorderRadius.circular(10),
                                  onPressed: (int newIndex) {
                                    setState(() {
                                      for (int index = 0;
                                          index < _selectedGraphs.length;
                                          index++) {
                                        if (index == newIndex) {
                                          _selectedGraphs[index] = true;
                                          _controller.animateToPage(index,
                                              duration: const Duration(
                                                  microseconds: 500),
                                              curve: Curves.ease);
                                        } else {
                                          _selectedGraphs[index] = false;
                                        }
                                      }
                                    });
                                  },
                                  constraints: BoxConstraints(
                                      minHeight: 70,
                                      minWidth: size.width / 3 - 15),
                                  children: MetricsList,
                                  isSelected: _selectedGraphs),
                            ),
                          ),
                          Row(
                            children: [
                              renderProperty('AVERAGE UPTIME', Blue200, IndividualAPIData.data[1].uptime),
                              addHorizontalSpace(8),
                              renderProperty('AVERAGE DOWNTIME', Blue200, '3%'),
                            ],
                          ),
                          addVerticalSpace(8),
                          Row(
                            children: [
                              renderProperty('AVERAGE OUTAGE DURATION', Blue400, '26 MIN'),
                              addHorizontalSpace(8),
                              renderProperty('MEAN TIME TO DETECT', Blue400, '3 MIN'),
                            ],
                          ),
                          addVerticalSpace(8),
                          Row(
                            children: [
                              renderProperty('TOTAL NUMBER OF OUTAGES', Blue600, '10'),
                              addHorizontalSpace(8),
                              renderProperty('UI RESPONSE TIME', Blue600, '303ms'),
                            ],
                          ),
                          addVerticalSpace(8),
                          Row(
                            children: [
                              renderProperty('AVERAGE API RESPONSE TIME', Blue700, '413ms'),
                              addHorizontalSpace(8),
                              renderProperty('ERROR LOGS', Blue700, '1123122'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  renderProperty(String title, Color color, String value) {
    return Expanded(child: Container(
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

const List<Widget> MetricsList = <Widget>[
  Text('UPTIME'),
  Text('OUTAGES'),
  Text('MTTD'),
  Text('LIVE'),
  Text('TBD')
];
