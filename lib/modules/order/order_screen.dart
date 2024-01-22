import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold)),
      ),
      body: const Center(
        child: Text('Order Screen Content'),
      ),
    );
  }
}
