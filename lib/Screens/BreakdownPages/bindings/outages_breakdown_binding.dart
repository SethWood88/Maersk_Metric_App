import 'package:get/get.dart';
import 'package:metrics_app/Screens/BreakdownPages/controllers/outages_breakdown_controller.dart';

class OutageBreakDownBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OutagesBreakdownController());
  }
}