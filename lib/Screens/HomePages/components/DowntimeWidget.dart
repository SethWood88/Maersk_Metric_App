
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../../utils/sample_data.dart';

class DowntimeWidget extends StatelessWidget {
  const DowntimeWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: DowntimeData.data.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          var item = DowntimeData.data[index];
          return Card(
              color: item.p == 'P1' ? DANGER : Colors.orange,
              child: ListTile(
                onTap: () => Get.toNamed('/outage_report/${item.id}'),
                leading: SizedBox(
                  width: 100,
                  child: AutoSizeText(
                    item.apiName.toString(),
                    style: const TextStyle(fontSize: 16, color: COLOR_WHITE),
                    maxLines: 3,
                  ),
                ),
                trailing: AutoSizeText(item.outage.toString(), maxLines: 1),
              ));
        });
  }
}
