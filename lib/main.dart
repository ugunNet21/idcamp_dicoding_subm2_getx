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

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello World!'),
//         ),
//       ),
//     );
//   }
// }
