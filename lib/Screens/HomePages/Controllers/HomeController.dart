import 'package:get/get.dart';
import 'package:metrics_app/Models/APIStatusModel.dart';
import 'package:metrics_app/Screens/HomePages/providers/home_provider.dart';

import '../../../Models/APIReportModel.dart';

class HomeController extends GetxController {
  final HomeProvider _provider = HomeProvider();
  List<APIStatusModel> models = [];
  bool isWaiting = false;

  @override
  void onInit() {
    super.onInit();
    loadModels();
  }

  void navigateToOutStatesBreakDown() {

  }

  Future<List<APIStatusModel>> loadModels() async {
    models = await _provider.fetchData() ?? [];
    update();
    return models;
  }
}