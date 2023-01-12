import 'package:get/get.dart';
import 'package:metrics_app/Screens/HomePages/providers/home_provider.dart';

import '../../../Models/IndividualAPIModel.dart';

class HomeController extends GetxController {
  final HomeProvider _provider = HomeProvider();
  List<AllAPIModel> models = [];
  bool isWaiting = false;

  @override
  void onInit() {
    super.onInit();

    loadModels();
  }

  void navigateToOutStatesBreakDown() {

  }

  Future<List<AllAPIModel>> loadModels() async {
    models = await _provider.fetchData() ?? [];
    update();
    return models;
  }
}