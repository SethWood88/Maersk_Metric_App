import 'package:get/get.dart';
import 'package:metrics_app/utils/sample_data.dart';

class OutagesBreakdownController extends GetxController {
  int? id;

  @override
  void onInit() {
    super.onInit();
    id = int.tryParse(Get.parameters['id'] ?? '-1') ?? -1;
  }

  APIData? selected() {
    if (id != null) {
      return IndividualAPIData.data[id ?? -1];
    } else {
      return null;
    }
  }
}