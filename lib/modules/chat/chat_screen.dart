import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold)),
      ),
      body: const Center(
        child: Text('Chat Screen Content'),
      ),
    );
  }
}
