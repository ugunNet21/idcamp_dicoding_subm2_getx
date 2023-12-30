
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String pictureId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Image'),
      ),
      body: Center(
        child: Image.network('https://restaurant-api.dicoding.dev/images/medium/$pictureId'),
      ),
    );
  }
}