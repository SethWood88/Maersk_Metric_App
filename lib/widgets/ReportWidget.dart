import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/Screens/BreakdownPages/MonthlyBreakdownPage/MonthlyBreakdown.dart';
import 'package:metrics_app/Screens/BreakdownPages/OutageBreakdownPage/OutageBreakdown.dart';
import 'package:metrics_app/Screens/FiltersPage/Filter.dart';
import 'package:metrics_app/Screens/HomePages/LandingScreen.dart';
import 'package:metrics_app/utils/sample_data.dart';

import '../CustomObjects/OutlineGraphic.dart';
import '../CustomObjects/Graphs.dart';
import '../utils/constants.dart';
import '../utils/widget_functions.dart';
import 'IndividualWidget.dart';

class ReportWidget extends StatefulWidget {
  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  final List<bool> _isSelected = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: 400,
            height: 300,
            child: Container(
              color: COLOR_BLACK,
              child: ClipRRect(
                clipBehavior: Clip.none,
                child: Stack(
                  children: [
                    Container(
                      child: CustomPaint(
                        size: const Size(490, 0),
                        painter: LeftAveragedReportGraphic(),
                      ),
                    ),
                    Container(
                      width: 500,
                      height: 300,
                      margin: const EdgeInsets.fromLTRB(10, 60, 10, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: COLOR_BLACK),
                      child: const GraphSwipe(),
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FilterDropDown()));
                              },
                              icon: const Icon(Icons.filter_alt_rounded),
                              iconSize: 25,
                            )),
                        addHorizontalSpace(215),
                        Container(
                            margin: const EdgeInsets.fromLTRB(30, 7, 10, 10),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Options()));
                              },
                              icon: const Icon(Icons.settings_sharp),
                              iconSize: 25,
                            )),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(98, 0, 0, 0),
                      child: Column(
                        children: [
                          const Text(
                            'MONTHLY',
                            style: TextStyle(color: COLOR_WHITE, fontSize: 20),
                          ),
                          const Text(
                            'AVERAGES',
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(260, 0, 104, 0),
                      child: RawMaterialButton(onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportWidgetBreakdown()));
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GraphSwipe extends StatefulWidget {
  const GraphSwipe({Key? key}) : super(key: key);

  @override
  State<GraphSwipe> createState() => _GraphSwipeState();
}

class _GraphSwipeState extends State<GraphSwipe> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView(
        physics: RangeMaintainingScrollPhysics(),
        controller: _controller,
        padEnds: true,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: <Widget>[
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(145, 0, 0, 0),
                child: Text(
                  'Uptime',
                  style: TextStyle(color: COLOR_WHITE, fontSize: 28),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(130, 190, 0, 0),
                child: Text(
                  'Last 30 Days',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Container(
                  clipBehavior: Clip.none,
                  margin: EdgeInsets.fromLTRB(20, 60, 0, 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: LineChartWidget(),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(130, 0, 0, 0),
                child: Text(
                  'Outages',
                  style: TextStyle(color: COLOR_WHITE, fontSize: 28),
                ),
              ),
              Center(
                child: Container(
                  clipBehavior: Clip.none,
                  margin: EdgeInsets.fromLTRB(20, 45, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: DowntimeWidget(),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}

class DowntimeWidget extends StatefulWidget {
  const DowntimeWidget({Key? key}) : super(key: key);

  @override
  State<DowntimeWidget> createState() => _DowntimeWidgetState();
}

class _DowntimeWidgetState extends State<DowntimeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: DowntimeData.data.length,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return RawMaterialButton(
            onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OutagesBreakdownPage(
                          individualIndex: index,
                        )));},
            child: LayoutBuilder(builder: (context, constraints) {
              if (DowntimeData.data[index].p == 'P1') {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: DANGER),
                      child: ListTile(
                        leading: Container(
                            width: 100,
                            child: AutoSizeText(
                              DowntimeData.data[index].apiName.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: COLOR_WHITE),
                              maxLines: 3,
                            )),
                        trailing: AutoSizeText(
                          DowntimeData.data[index].outage.toString(),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    addVerticalSpace(10),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange),
                      child: ListTile(
                        leading: Container(
                            width: 100,
                            child: AutoSizeText(
                              DowntimeData.data[index].apiName.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: COLOR_WHITE),
                              maxLines: 3,
                            )),
                        trailing: AutoSizeText(
                          DowntimeData.data[index].outage.toString(),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    addVerticalSpace(10),
                  ],
                );
              }
            }),
          );
        });
  }
}
