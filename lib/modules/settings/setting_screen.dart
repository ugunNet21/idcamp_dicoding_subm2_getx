
import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/settings/setting_controller.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  final SettingController controller = Get.find();
  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
      body: Center(
        child: Obx(
          () => Switch(
            value: controller.isReminderOn.value,
            onChanged: (value) {
              controller.toggleReminder();
            },
          ),
        ),
      ),
    );
  }
}
