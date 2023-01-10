import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/Screens/BreakdownPages/MonthlyBreakdownPage/MonthlyBreakdown.dart';
import 'package:metrics_app/Screens/BreakdownPages/OutageBreakdownPage/OutageBreakdown.dart';
import 'package:metrics_app/Screens/FiltersPage/Filter.dart';
import 'package:metrics_app/utils/sample_data.dart';
import 'package:metrics_app/utils/widget_functions.dart';

import '../CustomObjects/Graphs.dart';
import '../CustomObjects/OutlineGraphic.dart';
import '../utils/constants.dart';

class ReportWidget extends StatefulWidget {
  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  final List<bool> _isSelected = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 300,
        child: CustomPaint(
          painter: LeftAveragedReportGraphic(),
          child: Column(
            children: [
              Row(
                children: [
                  addHorizontalSpace(5),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 24),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterDropDown()));
                        },
                        icon: const Icon(Icons.filter_alt_rounded),
                        iconSize: 25,
                      )),
                  addHorizontalSpace(25),
                  Container(
                      width: 90,
                      child: Text(
                        "MONTHLY REPORT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  addHorizontalSpace(125),
                  Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 24),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportWidgetBreakdown()));
                        },
                        icon: const Icon(Icons.menu_rounded),
                        iconSize: 35,
                      )),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: COLOR_BLACK),
                  child: const GraphSwipe(),
                ),
              ),
            ],
          ),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: RangeMaintainingScrollPhysics(),
      controller: _controller,
      padEnds: true,
      children: <Widget>[
        Column(
          children: [
            Text(
              'Uptime',
              style: TextStyle(color: COLOR_WHITE, fontSize: 28),
            ),
            Expanded(child: LineChartWidget()),
            Text(
              'Last 30 Days',
              style: TextStyle(fontSize: 15, color: COLOR_WHITE),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Outages',
              style: TextStyle(color: COLOR_WHITE, fontSize: 28),
            ),
            Expanded(child: DowntimeWidget())
          ],
        ),
      ],
    );
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
        padding: EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          return Card(
              color:
                  DowntimeData.data[index].p == 'P1' ? DANGER : Colors.orange,
              child: ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OutagesBreakdownPage(
                              individualIndex: index,
                            ))),
                leading: AutoSizeText(
                  DowntimeData.data[index].apiName.toString(),
                  style: TextStyle(fontSize: 16, color: COLOR_WHITE),
                  maxLines: 3,
                ),
                trailing: AutoSizeText(
                  DowntimeData.data[index].outage.toString(),
                  maxLines: 1,
                ),
              ));
        });
  }
}
