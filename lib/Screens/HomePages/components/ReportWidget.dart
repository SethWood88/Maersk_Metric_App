import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/Screens/BreakdownPages/views/MonthlyBreakdownPage/MonthlyBreakdown.dart';
import 'package:metrics_app/Screens/FiltersPage/Filter.dart';

import '../../../CustomObjects/OutlineGraphic.dart';
import '../../../utils/constants.dart';
import 'GraphSwipe.dart';

class ReportWidget extends StatefulWidget {
  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: SizedBox(
        height: 300,
        child: CustomPaint(
          painter: LeftAveragedReportGraphic(),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 30, top: 5),
                      child: IconButton(
                        onPressed: () => Get.toNamed('/filters'),
                        icon: const Icon(Icons.filter_alt_rounded),
                        iconSize: 30,
                      )),
                  Expanded(
                      child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'MONTHLY\nAVERAGES',
                          style: TextStyle(color: COLOR_WHITE, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
                  Container(
                      margin: const EdgeInsets.only(right: 24),
                      child: IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MonthlyBreakdown())),
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
                      borderRadius: BorderRadius.circular(25),
                      color: COLOR_BLACK),
                  child: GraphSwipe(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
