import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/Screens/FiltersPage/Filter.dart';
import 'package:metrics_app/widgets/ReportWidget.dart';
import 'package:metrics_app/Screens/HomePages/views/Home.dart';
import 'package:metrics_app/utils/sample_data.dart';

import '../../../CustomObjects/OutlineGraphic.dart';
import '../../../CustomObjects/Graphs.dart';
import '../../../utils/constants.dart';
import '../../../utils/widget_functions.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ReportWidgetBreakdown extends StatefulWidget {
  @override
  State<ReportWidgetBreakdown> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidgetBreakdown> {
  final List<bool> _selectedGraphs = <bool>[true, false, false, false, false];
  bool vertical = false;
  late final List<int> _Index = <int>[0, 1, 2, 3, 4];
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BLACK,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: COLOR_BLACK,
                child: Stack(
                  children: [
                    Container(
                      child: CustomPaint(
                        size: const Size(490, 0),
                        painter: IndividualBreakdownGraphic(),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      margin: const EdgeInsets.fromLTRB(10, 60, 10, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: COLOR_BLACK),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 300, 20, 330),
                      child: Container(
                          width: size.width,
                          height: size.height,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(35, 100, 10, 390),
                      child: PageView(
                        clipBehavior: Clip.none,
                        physics: NeverScrollableScrollPhysics(),
                        controller: _controller,
                        children: [
                          LineChartWidget(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: DowntimeWidget(),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: size.width - 20,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white10,
                      ),
                      margin: EdgeInsets.fromLTRB(20, 300, 20, 0),
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
                                        duration:
                                            const Duration(microseconds: 500),
                                        curve: Curves.ease);
                                  } else {
                                    _selectedGraphs[index] = false;
                                  }
                                }
                              });
                            },
                            constraints: BoxConstraints(
                                minHeight: 70, minWidth: size.width / 3 - 15),
                            children: MetricsList,
                            isSelected: _selectedGraphs),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          addVerticalSpace(360),
                          Row(
                            children: [
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue200),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 70,
                                        child: Text(
                                          'AVERAGE UPTIME',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.white),
                                        )),
                                    addHorizontalSpace(35),
                                    Container(
                                        width: 55,
                                        child: Text(
                                          IndividualAPIData.data[1].uptime,
                                          style: TextStyle(
                                              fontSize: 22, color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              addHorizontalSpace(10),
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue200),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 85,
                                        child: Text(
                                          'AVERAGE DOWNTIME',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.white),
                                        )),
                                    addHorizontalSpace(25),
                                    Container(
                                        width: 40,
                                        child: Text(
                                          '3%',
                                          style: TextStyle(
                                              fontSize: 22, color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpace(10),
                          Row(
                            children: [
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue400),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 85,
                                        child: Text(
                                          'AVERAGE OUTAGE DURATION',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white),
                                        )),
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          '26 MIN',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              wordSpacing: 1),
                                        )),
                                  ],
                                ),
                              ),
                              addHorizontalSpace(10),
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue400),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 70,
                                        child: Text(
                                          'MEAN TIME TO DETECT',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white),
                                        )),
                                    addHorizontalSpace(30),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          '3 MIN',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpace(10),
                          Row(
                            children: [
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue600),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 70,
                                        child: Text(
                                          'TOTAL NUMBER OF OUTAGES',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white),
                                        )),
                                    addHorizontalSpace(50),
                                    Container(
                                        width: 30,
                                        child: Text(
                                          '10',
                                          style: TextStyle(
                                              fontSize: 25, color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              addHorizontalSpace(10),
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue600),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          'UI RESPONSE TIME',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white),
                                        )),
                                    addHorizontalSpace(45),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          '303ms',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpace(10),
                          Row(
                            children: [
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue700),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 85,
                                        child: Text(
                                          'AVERAGE API RESPONSE TIME',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white),
                                        )),
                                    addHorizontalSpace(20),
                                    Container(
                                        width: 50,
                                        child: Text(
                                          '413ms',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              addHorizontalSpace(10),
                              Container(
                                width: 175,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Blue700),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHorizontalSpace(10),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          'ERROR LOGS',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white),
                                        )),
                                    addHorizontalSpace(40),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          '11231221',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                                        builder: (context) => B2CPage()));
                              },
                              icon: const Icon(Icons.arrow_back_rounded),
                              iconSize: 30,
                            )),
                        addHorizontalSpace(215),
                        Container(
                            margin: const EdgeInsets.fromLTRB(30, 7, 10, 10),
                            child: IconButton(
                              onPressed: () {},
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
                            'MONTH',
                            style: TextStyle(color: COLOR_WHITE, fontSize: 20),
                          ),
                          const Text(
                            'BREAKDOWN',
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Padding(
// padding: EdgeInsets.fromLTRB(30, 120, 10, 420),
// child: Container(
// width: size.width,
// height: size.height,
// child: LineChartWidget(),
// ),
// );

class GraphSwipeSelector extends StatefulWidget {
  const GraphSwipeSelector({Key? key}) : super(key: key);

  @override
  State<GraphSwipeSelector> createState() => _GraphSwipeState();
}

class _GraphSwipeState extends State<GraphSwipeSelector> {
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
                  'Downtime',
                  style: TextStyle(color: COLOR_WHITE, fontSize: 28),
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
                margin: EdgeInsets.fromLTRB(145, 0, 0, 0),
                child: Text(
                  '',
                  style: TextStyle(color: COLOR_WHITE, fontSize: 28),
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
          )
        ],
      ),
    ]);
  }
}

const List<Widget> MetricsList = <Widget>[
  Text('UPTIME'),
  Text('OUTAGES'),
  Text('MTTD'),
  Text('LIVE'),
  Text('TBD')
];

class GraphSwitch extends StatefulWidget {
  const GraphSwitch({Key? key}) : super(key: key);

  @override
  State<GraphSwitch> createState() => _GraphSwitchState();
}

class _GraphSwitchState extends State<GraphSwitch> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      children: const <Widget>[],
    );
  }
}
