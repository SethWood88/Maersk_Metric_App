import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';

import '../../HomePages/views/Home.dart';
import '../../../utils/constants.dart';
import '../../../utils/sample_data.dart';
import '../../../utils/widget_functions.dart';

class OutagesBreakdownPage extends StatefulWidget {
  OutagesBreakdownPage({required this.individualIndex});

  var individualIndex;
  @override
  State<OutagesBreakdownPage> createState() =>
      _OutagesBreakdownPageState(iIndex: individualIndex);
}

class _OutagesBreakdownPageState extends State<OutagesBreakdownPage> {
  var iIndex;
  _OutagesBreakdownPageState({required this.iIndex});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: COLOR_BLACK,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: size.width,
                height: size.height - 24,
                child: ClipRRect(
                  clipBehavior: Clip.none,
                  child: Stack(
                    children: [
                      Container(
                        child: CustomPaint(painter: OutageBreakdownGraphic()
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
                      Column(
                        children: [
                          addHorizontalSpace(315),
                          Container(
                            width: 120,
                            child: Column(
                              children: [
                                AutoSizeText(
                                  IndividualAPIData.data[iIndex].apiName.toString(),
                                  maxLines: 1,
                                  style:
                                      TextStyle(color: COLOR_WHITE, fontSize: 24),
                                ),
                                Text(
                                  'OUTAGE REPORT',
                                  style: TextStyle(
                                    color: COLOR_WHITE,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(30, 8, 0, 0),
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
