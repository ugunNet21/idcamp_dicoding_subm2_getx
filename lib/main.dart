import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/routes/app_pages.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:get/get.dart';
void main() {
  runApp(
    GetMaterialApp(
      title: 'Finder Resto',
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.pages,
    ),
  );
}