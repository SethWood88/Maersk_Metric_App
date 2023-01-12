
import 'package:flutter/material.dart';

import '../../../CustomObjects/Graphs.dart';
import '../../../utils/constants.dart';
import 'DowntimeWidget.dart';

class GraphSwipe extends StatelessWidget {

  GraphSwipe({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const RangeMaintainingScrollPhysics(),
      controller: _controller,
      padEnds: true,
      children: <Widget>[
        Column(
          children: [
            const Text(
              'Uptime',
              style: TextStyle(color: COLOR_WHITE, fontSize: 28),
            ),
            Expanded(child: LineChartWidget()),
            const Text(
              'Last 30 Days',
              style: TextStyle(fontSize: 15, color: COLOR_WHITE),
            ),
          ],
        ),
        Column(
          children: const [
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
