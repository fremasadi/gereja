import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
