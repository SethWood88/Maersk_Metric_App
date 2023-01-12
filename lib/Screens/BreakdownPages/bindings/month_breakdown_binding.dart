import 'package:get/get.dart';

import '../controllers/month_breakdown_controller.dart';

class MonthBreakdownBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MonthBreakdownController());
  }
}