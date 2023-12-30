import 'package:flutter_subm2_getx/modules/detail/detail_bindings.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_view.dart';
import 'package:flutter_subm2_getx/modules/home/home_bindings.dart';
import 'package:flutter_subm2_getx/modules/home/home_view.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_bindings.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_view.dart';
import 'package:flutter_subm2_getx/modules/search/search_bindings.dart';
import 'package:flutter_subm2_getx/modules/search/search_view.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => DetailView(),
      binding: DetailBindings(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => SearchView(),
      binding: SearchBindings(),
    ),
    GetPage(
      name: AppRoutes.addReview,
      page: () => AddReviewView(),
      binding: AddReviewBindings(),
    ),
  ];
}