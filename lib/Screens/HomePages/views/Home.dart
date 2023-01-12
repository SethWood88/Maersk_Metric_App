import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrics_app/CustomObjects/OutlineGraphic.dart';
import 'package:metrics_app/Screens/HomePages/Controllers/HomeController.dart';
import 'package:metrics_app/utils/widget_functions.dart';
import 'package:metrics_app/Screens/HomePages/components/ReportWidget.dart';

import '../../../Models/IndividualAPIModel.dart';
import '../../../utils/constants.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_BLACK,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: [
              ReportWidget(),
              addVerticalSpace(10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CustomPaint(
                    painter: IndividualAPIGraphics(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      decoration: const BoxDecoration(
                          color: COLOR_BLACK,
                          borderRadius: BorderRadius.all(Radius.circular(36))),
                      child: FutureBuilder<List<AllAPIModel>>(
                          future: controller.loadModels(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.data == null) {
                                return const Center(
                                  child: Text('Data is empty'),
                                );
                              } else {
                                return ListView.builder(
                                  padding: const EdgeInsets.all(12),
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, int index) {
                                    return ListTile(
                                        title: Text(
                                            snapshot.data
                                                ?.elementAt(index)
                                                .name
                                                .toString() ??
                                                ''
                                        ),
                                        textColor: COLOR_WHITE
                                    );
                                  },
                                );
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return const Center(
                                child: Text('Connection Failed'),
                              );
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
                ),
              )
            ])),
      ),
    );
  }

}