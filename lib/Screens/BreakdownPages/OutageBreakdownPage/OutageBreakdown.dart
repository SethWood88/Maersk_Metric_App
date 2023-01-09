import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';

import '../../../utils/constants.dart';
import '../../../utils/sample_data.dart';
import '../../../utils/widget_functions.dart';
import '../../HomePages/views/Home.dart';

class OutagesBreakdownPage extends StatefulWidget {
  OutagesBreakdownPage({required this.individualIndex});

  final int individualIndex;

  @override
  State<OutagesBreakdownPage> createState() =>
      _OutagesBreakdownPageState(iIndex: individualIndex);
}

class _OutagesBreakdownPageState extends State<OutagesBreakdownPage> {
  var iIndex;

  _OutagesBreakdownPageState({required this.iIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: COLOR_BLACK,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CustomPaint(
          painter: OutageBreakdownGraphic(),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: 30,
                  ),
                  Column(
                    children: [
                      AutoSizeText(
                        IndividualAPIData.data[iIndex].apiName,
                        maxLines: 1,
                        style: TextStyle(color: COLOR_WHITE, fontSize: 24),
                      ),
                      Text(
                        'OUTAGE REPORT',
                        style: TextStyle(
                          color: COLOR_WHITE,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(16, 4, 16, 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: COLOR_BLACK),
                // child: ,
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
