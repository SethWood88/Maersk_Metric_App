import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:metrics_app/Models/APIStatusModel.dart';

import '../../../Models/APIReportModel.dart';
import '../../../utils/endpoints.dart';

class HomeProvider extends GetConnect {

  @override
  void onInit() {
    super.onInit();
    baseUrl = baseProdURL;
  }

  Future<List<APIStatusModel>?> fetchData() async {
    try {
      final res = await get('https://wwa-salutemmetrics-ncus-prod.azurewebsites.net/api/v1/GetAllChecksCurrentStatus/Page0');
      if (res.statusCode == 200) {
        return APIStatusModel.fromArrayJson(res.body);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Future(() => []);
  }
}