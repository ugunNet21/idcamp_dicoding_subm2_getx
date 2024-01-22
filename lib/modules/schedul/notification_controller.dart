import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NotificationController extends GetxController {
  final ApiService apiService;
  NotificationController({required this.apiService});

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  notificationManager() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showRandomRestaurantNotification() async {
    try {
      final ApiService apiService = ApiService();
      final response = await apiService.getRandomRestaurants();

      if (!response['error'] && response['restaurants'] != null) {
        final List<dynamic> restaurantsData = response['restaurants'];
        final List<String> restaurantNames =
            restaurantsData.map((data) => data['name'].toString()).toList();

        final random = Random();
        final randomIndex = random.nextInt(restaurantNames.length);
        final randomRestaurantName = restaurantNames[randomIndex];

        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'restaurant_channel_id',
          'Restaurant Channel',
          importance: Importance.max,
          priority: Priority.high,
        );

        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
          0,
          'Daily Restaurant Reminder',
          'Check out today\'s featured restaurant: $randomRestaurantName',
          platformChannelSpecifics,
        );
      } else {
        throw Exception('Failed to get random restaurants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
