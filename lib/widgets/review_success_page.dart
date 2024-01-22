import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:get/get.dart';

class ReviewSuccessView extends StatelessWidget {
  const ReviewSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 64,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            const Text(
              'Review added successfully.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Get.offNamed(AppRoutes.bottomNav);
              },
              child: const Text('Back to home'),
            ),
          ],
        ),
      ),
    );
  }
}
