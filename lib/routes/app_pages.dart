import 'package:flutter_subm2_getx/modules/home/home_bindings.dart';
import 'package:flutter_subm2_getx/modules/home/home_view.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    // Add other pages as needed
  ];
}