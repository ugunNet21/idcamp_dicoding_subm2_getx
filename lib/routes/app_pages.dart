import 'package:flutter_subm2_getx/modules/detail/detail_bindings.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_view.dart';
import 'package:flutter_subm2_getx/modules/home/home_bindings.dart';
import 'package:flutter_subm2_getx/modules/home/home_view.dart';
import 'package:flutter_subm2_getx/modules/restaurant_image/restaurant_image_view.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_bindings.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_view.dart';
import 'package:flutter_subm2_getx/modules/search/search_bindings.dart';
import 'package:flutter_subm2_getx/modules/search/search_view.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.DETAIL,
      page: () => DetailView(),
      binding: DetailBindings(),
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => SearchView(),
      binding: SearchBindings(),
    ),
    GetPage(
      name: AppRoutes.ADD_REVIEW,
      page: () => AddReviewView(),
      binding: AddReviewBindings(),
    ),
    GetPage(
      name: AppRoutes.RESTAURANT_IMAGE,
      page: () => RestaurantImageView(),
    ),
    // Add other pages as needed
  ];
}