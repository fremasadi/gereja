import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/giving_controller.dart';

class GivingView extends GetView<GivingController> {
  const GivingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GivingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GivingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
