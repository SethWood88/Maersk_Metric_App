import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/utils/sample_data.dart';

import '../utils/constants.dart';
import '../utils/widget_functions.dart';

class IndividualWidget extends StatelessWidget {
  final GestureTapCallback onPressed;
  static const double verticalPadding = 25;
  static const double sidePadding = 0;

  var index;
  var apiName;
  var uptime;

  IndividualWidget(
      {required this.onPressed,
      required this.index,
      required this.apiName,
      required this.uptime});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40)),
                child: SizedBox(
                  width: 290,
                  height: 52,
                  child: RawMaterialButton(
                    onPressed: onPressed,
                    fillColor: DARKBLUE,
                    splashColor: COLOR_BLACK,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(0))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addHorizontalSpace(10),
                          Container(
                            width: 150,
                            child: AutoSizeText(
                                IndividualAPIData.data[index].apiName
                                    .toString(),
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: COLOR_WHITE,
                                )),
                          ),
                          addHorizontalSpace(50),
                          LayoutBuilder(builder: (context, constraints) {
                            if (IndividualAPIData.data[index].status ==
                                'LIVE') {
                              return Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    IndividualAPIData.data[index].status
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: SUCCESS,
                                    )),
                              );
                            } else {
                              return Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    IndividualAPIData.data[index].status
                                        .toString(),
                                    style:
                                        TextStyle(fontSize: 24, color: DANGER)),
                              );
                            }
                          })
                        ]),
                  ),
                ),
              ),
              addHorizontalSpace(10),
              Container(
                  width: 35,
                  height: 52,
                  child: RawMaterialButton(
                    onPressed: onPressed,
                    fillColor: DARKBLUE,
                    splashColor: COLOR_WHITE,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                  ))
            ],
          ),
          addVerticalSpace(10),
        ]),
      ),
    );
  }
}

class ArrowOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: COLOR_GREY,
        size: 18,
      ),
    );
  }
}
