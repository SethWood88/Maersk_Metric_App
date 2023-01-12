import 'package:get/get.dart';
import 'package:metrics_app/Screens/root/controllers/root_controller.dart';

class RootBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(RootController());
  }
}