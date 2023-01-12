import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Models/IndividualAPIModel.dart';
import '../../../utils/endpoints.dart';

class HomeProvider extends GetConnect {

  @override
  void onInit() {
    super.onInit();
    baseUrl = baseProdURL;
  }

  Future<List<AllAPIModel>?> fetchData() async {
    try {
      final res = await get(allAPIData);
      if (res.statusCode == 200) {
        return AllAPIModel.fromArrayJson(res.body);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Future(() => []);
  }
}