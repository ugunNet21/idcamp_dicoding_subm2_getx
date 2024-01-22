import 'package:flutter_subm2_getx/modules/settings/setting_bindings.dart';
import 'package:flutter_subm2_getx/modules/settings/setting_screen.dart';
import 'package:flutter_subm2_getx/modules/chat/chat_screen.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_bindings.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_view.dart';
import 'package:flutter_subm2_getx/modules/favorite/favorite_bindings.dart';
import 'package:flutter_subm2_getx/modules/favorite/favorite_screen.dart';
import 'package:flutter_subm2_getx/modules/home/home_bindings.dart';
import 'package:flutter_subm2_getx/modules/home/home_view.dart';
import 'package:flutter_subm2_getx/modules/login/login_screen.dart';
import 'package:flutter_subm2_getx/modules/navigation/bottom_bindings.dart';
import 'package:flutter_subm2_getx/modules/navigation/bottom_navigation.dart';
import 'package:flutter_subm2_getx/modules/order/order_screen.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_bindings.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_view.dart';
import 'package:flutter_subm2_getx/modules/search/search_bindings.dart';
import 'package:flutter_subm2_getx/modules/search/search_view.dart';
import 'package:flutter_subm2_getx/modules/splash/splash_screen.dart';
import 'package:flutter_subm2_getx/widgets/review_failed_page.dart';
import 'package:flutter_subm2_getx/widgets/review_success_page.dart';
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
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => const BottomNavigationScreen(),
      binding: BottomBindings(),
    ),
    GetPage(
      name: AppRoutes.order,
      page: () => const OrderScreen(),
    ),
    GetPage(
      name: AppRoutes.favorite,
      page: () =>    FavoriteView(),
      binding: FavoriteBindings(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () =>  SettingScreen(),
      binding: SettingBindings(),
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
    GetPage(
      name: AppRoutes.reviewSuccess,
      page: () => const ReviewSuccessView(),
    ),
    GetPage(
      name: AppRoutes.reviewFailed,
      page: () => const ReviewFailedView(),
    ),
  ];
}
