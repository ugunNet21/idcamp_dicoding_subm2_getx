import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/account/account_screen.dart';
import 'package:flutter_subm2_getx/modules/chat/chat_screen.dart';
import 'package:flutter_subm2_getx/modules/favorite/favorite_screen.dart';
import 'package:flutter_subm2_getx/modules/home/home_view.dart';
import 'package:flutter_subm2_getx/modules/navigation/bottom_nav_controller.dart';
import 'package:flutter_subm2_getx/modules/order/order_screen.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
import 'package:get/get.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());

  final List<Widget> _screens = [
    HomeView(),
    const ChatScreen(),
    const OrderScreen(),
      FavoriteView(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => _screens[controller.currentIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.changePage(index);
            },
            selectedItemColor: redColor,
            unselectedItemColor: greyColor,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
          ),
        ));
  }
}
