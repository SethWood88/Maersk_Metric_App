import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/Screens/BreakdownPages/controllers/outages_breakdown_controller.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/widget_functions.dart';

class OutagesBreakdownPage extends GetView<OutagesBreakdownController> {
  const OutagesBreakdownPage({super.key});

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
                  addHorizontalSpace(20),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: 30,
                  ),
                  addHorizontalSpace(32),
                  Column(
                    children: [
                      AutoSizeText(
                        controller.selected()?.apiName ?? '',
                        maxLines: 1,
                        style: const TextStyle(color: COLOR_WHITE, fontSize: 24),
                      ),
                      const Text(
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
                margin: const EdgeInsets.fromLTRB(16, 4, 16, 24),
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
