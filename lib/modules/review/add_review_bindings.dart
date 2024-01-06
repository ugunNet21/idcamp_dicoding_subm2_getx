
import 'package:flutter_subm2_getx/modules/review/add_review_controller.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class AddReviewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddReviewController>(() => AddReviewController(
          apiService: ApiService(),
        ));
  }
}
// scaffoldKey: GlobalKey<ScaffoldMessengerState>(),